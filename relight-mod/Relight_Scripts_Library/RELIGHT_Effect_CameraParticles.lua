--Relight Camera Particles
--Creates one camera particle prop (dust motes, pollen, rain... from Relight_Assets_GameOverrides) and keeps it
--on the current scene camera every frame, so it follows camera cuts. Only moves the agent it created itself.

RELIGHT_CameraParticles_PropFile = "fx_camDustMotes.prop";

local agent_cameraParticles = nil;

RELIGHT_CameraParticles_Initalize = function()
    agent_cameraParticles = nil;
    local agent_camera = SceneGetCamera(RELIGHT_SceneObject);

    if (agent_camera == nil) then
        return;
    end

    agent_cameraParticles = AgentCreate("RELIGHT_CameraParticles", RELIGHT_CameraParticles_PropFile, AgentGetWorldPos(agent_camera), AgentGetWorldRot(agent_camera), RELIGHT_SceneObject, false, false);
end

RELIGHT_CameraParticles_Update = function()
    if (agent_cameraParticles == nil) then
        return;
    end

    local agent_camera = SceneGetCamera(RELIGHT_SceneObject);

    if (agent_camera == nil) then
        return;
    end

    AgentSetWorldPos(agent_cameraParticles, AgentGetWorldPos(agent_camera));
    AgentSetWorldRot(agent_cameraParticles, AgentGetWorldRot(agent_camera));
end
