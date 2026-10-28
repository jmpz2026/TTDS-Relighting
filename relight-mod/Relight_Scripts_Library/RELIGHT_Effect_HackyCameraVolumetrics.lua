--[[
Developer Notes: 
Yes. I am very very very very very well aware that this is not an ideal implementation.
However, given the circumstances at the time of writing we have no access or no knowledge of how to extract and decompile the game shaders yet.
Trust me, if we had the access and the tools I wouldn't have done it this way. 
There are alot of issues doing it this way, but I did it this way both out of experimentation but also (and mostly) by complete accident :P
As a result of the experiment led to something that works suprisingly ok roughly 60% of the time.

This works by using an object with a semi-transparent material that recieve shadows, many are spawned in front of the camera at a specific step distance, for X amount of samples.
Very similar to raymarching where we step into the scene, but these planes will automatically recieve shadows from oncoming lightsources that intersects the volumetric planes.
This works rather well, however due to this setup this introduces alot of issues and drawbacks...

The issues...
1. When the the camera view direction starts to become parallel with a given light direction, the "effect" disappears for that light. 
This is because the current material being used for the "volumetric" planes still have the classic NdotL lighting on them.
So when the surface of the material is oriented away towards the light, it falls in shadow and the light no longer affects the plane.
This can be sort of fixed and alleviated by changing the light wrap modifier on light sources to its max but this causes obvious shading issues with other objects...
Ideally the material for the volumetric plane is one that is not affected by NdotL and can recieve shadows from light sources regardless of angle.

NOTE: One idea is to utilize the built in "lighting groups" that the tool has, and create duplicate meshes in the scene that are only affected by that lighting group.
Then what we do is on all regular cameras in the scene, there is a "Exclude Agents" which is a container and we just include the duplicated "shadow casting" agents for the volumetric lighting.
In theory this should be the perfect way to go about lighting the scene... however it means having a duplicate set of lights in the scene, and not only that a duplicate set of meshes... performance wise this sounds like it will be intensive...

2. Regular scene fog affects the volumetric lighting which muddies up the visuals quite a bit. 
The planes can still be affected by scene/environment fog so then you get doubled up fog which looks bad. 
Any other fog effects in the scene must be disabled for this to be unpolluted and look correct, especially since this effect is supposed to be "fog" itself.

3. All scene lights affect the result, which is physically correct in theory, but in practice due to lighting setups in telltale it looks off.
- eLightEnvType_Ambient (3): Ambient light being light that is completely flat and brightens everything with no directional information, this muddies up the visuals of the fog quite a bit.
- eLightEnvType_DirectionalAmbient (4): Like the ambient light, this will brighten everything in the scene. This has more directional information than the ambient but it still uniformly affects everything.

4. Another issue with this implementation is that there is no possible way to optimize this solution further by having it run mostly on the GPU.

5. In addition to issue #4 of the effect not being implemented as a shader, we can't apply noise or dithering to offset samples and reduce aliasing/stepping artifacts.
This would be a massive help to both improving quality and performance but unfortnautely we have to deal with brute force.

--Relight Volumetrics
RELIGHT_HackyCameraVolumetrics_Settings = 
{
    Samples = 256,
    SampleOffset = 0.05,
    SampleStartOffset = 1.0,
    FogColor = Color(0.05, 0.05, 0.05, 0.05),

    --Optional (performance). When Quality is set (1 low, 2 medium, 3 high), it replaces Samples/SampleOffset:
    --fewer planes over the same Range, packed near the camera (SpacingPower > 1) and each one denser, so the
    --total fog stays close to the 256 plane look. Quality 4 (or nil) is the original brute force setup.
    Quality = 2,
    Range = 12.8,          --meters covered by the planes (default Samples * SampleOffset)
    SpacingPower = 1.6,    --1 = even spacing, higher = more planes near the camera
    Jitter = 0.5,          --per frame random offset, in steps; temporal AA blends it and hides the banding
};
]]--

--Planes per quality level 1..3 (level 4 = the Samples value, 256 by default).
local RELIGHT_HackyCameraVolumetrics_QualitySamples = { 24, 48, 96 };
local number_jitterStep = 0;
local number_jitterIndex = 0;

local string_elementPropFile = "fx_glowWhite.prop" -- in 201 data
local string_agentGroupName = "RELIGHT_CameraVolumetricsParentGroup";
local string_volumePlaneAgentName = "RELIGHT_CameraVolumetricPlane_";
local agent_group = nil;

RELIGHT_HackyCameraVolumetrics_Initalize = function()
    agent_group = AgentCreate(string_agentGroupName, "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), RELIGHT_SceneObject, false, false);

    local settings = RELIGHT_HackyCameraVolumetrics_Settings;
    local number_samples = settings.Samples;
    local number_referenceOffset = settings.SampleOffset;
    local number_range = number_samples * number_referenceOffset;
    local number_power = 1.0;
    local number_quality = settings.Quality;

    if (number_quality ~= nil) and (RELIGHT_HackyCameraVolumetrics_QualitySamples[number_quality] ~= nil) then
        number_samples = RELIGHT_HackyCameraVolumetrics_QualitySamples[number_quality];
        number_range = settings.Range or number_range;
        number_power = settings.SpacingPower or 1.6;
    end

    number_jitterStep = (settings.Jitter or 0) * number_range / number_samples;
    if (number_quality == nil) or (number_quality >= 4) then
        number_jitterStep = 0;
    end

    local number_previousDistance = 0;

    for index = 1, number_samples, 1 do
        local number_distance = number_range * math.pow(index / number_samples, number_power);

        --Each plane stands for the slab of fog in front of it: thicker slab = denser plane (1 at the original 0.05 step).
        local number_density = (number_distance - number_previousDistance) / number_referenceOffset;
        number_previousDistance = number_distance;
        local color_fog = settings.FogColor;
        --Same transmittance as number_density stacked planes: 1 - (1 - a)^density; color scaled with alpha.
        local number_alpha = 1 - math.pow(1 - math.min(color_fog.a, 0.99), number_density);
        local number_scale = number_alpha / math.max(color_fog.a, 0.0001);
        local color_plane = Color(math.min(color_fog.r * number_scale, 1), math.min(color_fog.g * number_scale, 1), math.min(color_fog.b * number_scale, 1), number_alpha);

        local vector_currentPosition = Vector(0, 0, number_distance);
        local vector_currentRotation = Vector(0, 180, 0);

        local string_currentElementAgentName = string_volumePlaneAgentName .. tostring(index);
        local agent_currentElement = AgentCreate(string_currentElementAgentName, string_elementPropFile, vector_currentPosition, vector_currentRotation, RELIGHT_SceneObject, false, false);

        --NOTE: If scale is too small, when the volumetric planes are placed at a great distance from camera you will see a sort of "clipping" of the volumetric lighting which looks awkward.
        AgentSetProperty(agent_currentElement, "Render Global Scale", 1000.0);
        AgentSetProperty(agent_currentElement, "Render Cull", false);
        AgentSetProperty(agent_currentElement, "Render Layer", 25);
        AgentSetProperty(agent_currentElement, "Render Diffuse Color", color_plane);
        AgentSetProperty(agent_currentElement, "Render Constant Alpha Multiply", 1);
        AgentSetProperty(agent_currentElement, "Render After Anti-Aliasing", false);
        AgentSetProperty(agent_currentElement, "Render EnvLight Shadow Cast Enable", false);
        AgentSetProperty(agent_currentElement, "Motion Blur Enabled", false);
        AgentSetProperty(agent_currentElement, "Render Depth Test", true);
        AgentSetProperty(agent_currentElement, "Camera Facing", false);
        AgentSetProperty(agent_currentElement, "Render Static", false);
        AgentSetProperty(agent_currentElement, "Camera Facing Type", 0);
        AgentSetProperty(agent_currentElement, "Render Depth Write", false);
        AgentSetProperty(agent_currentElement, "Render Depth Write Alpha", false);
        AgentSetProperty(agent_currentElement, "Render 3D Alpha", false);
        AgentSetProperty(agent_currentElement, "Render Color Write", true);
        AgentSetProperty(agent_currentElement, "Render Force As Alpha", false);
        AgentSetProperty(agent_currentElement, "Render Depth Test Function", 4);
        AgentSetProperty(agent_currentElement, "Receive Shadows", true);
        AgentSetProperty(agent_currentElement, "Render FX Color Enabled", true);
        AgentSetProperty(agent_currentElement, "Render Shadow Force Visible", false);
        AgentSetProperty(agent_currentElement, "Render Enlighten Force Visible", false);
        AgentSetProperty(agent_currentElement, "fx_glowWhite - Texture", "color_fFFFFF");
        AgentSetProperty(agent_currentElement, "fx_glowWhite - Light Color Diffuse", color_plane);

        AgentAttach(agent_currentElement, agent_group);
    end
end

RELIGHT_HackyCameraVolumetrics_Update = function()
    local agent_currentCamera = SceneGetCamera(RELIGHT_SceneObject); --Agent type
    local vector_currentCameraPosition = AgentGetWorldPos(agent_currentCamera); --Vector type
    local vector_currentCameraForward = AgentGetForwardVec(agent_currentCamera); --Vector type
    local vector_currentCameraRotation = AgentGetWorldRot(agent_currentCamera); --Vector type

    --Golden ratio sequence: a different offset inside one step every frame, evenly spread over time.
    number_jitterIndex = (number_jitterIndex + 1) % 1000;
    local number_jitter = ((number_jitterIndex * 0.618034) % 1.0) * number_jitterStep;

    local vector_volumetricGroupPosition = VectorAdd(vector_currentCameraPosition, VectorScale(vector_currentCameraForward, RELIGHT_HackyCameraVolumetrics_Settings.SampleStartOffset + number_jitter));

    AgentSetWorldPos(agent_group, vector_volumetricGroupPosition);
    AgentSetRot(agent_group, vector_currentCameraRotation);
end