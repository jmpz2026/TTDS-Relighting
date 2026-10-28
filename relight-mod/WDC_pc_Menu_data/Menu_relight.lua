--Relight submenu: Options > Audio/Display > Relight.
--Reads and writes RelightMod/RelightConfiguration_Main.ini (the [Global] section), the same file the
--relight backend loads at the start of every scene. Each change is saved at once and applies on the
--next scene load (render scale also applies at once).
require("Utilities.lua")
require("UI_ListToggle.lua")
require("UI_Header.lua")
require("UI_Legend.lua")
require("Menu_ListMenu.lua")
require("UI_ListButton.lua")

--Keep equal to RELIGHT_CurrentConfigurationVersion in RELIGHT_RelightingConfiguration.lua.
local RELIGHT_MENU_ConfigurationVersion = 102;
local RELIGHT_MENU_ConfigFileName = "RelightMod/RelightConfiguration_Main.ini";

local mbLibrariesLoaded = pcall(require, "TLSE_INI.lua") and pcall(require, "RELIGHT_RelightingConfiguration_Main.lua");

local ON_OFF = { true, false };
local OFF_ON = { false, true };
local LABELS_ON_OFF = { "label_on", "label_off" };

--{ ini key, label, values, display labels, literal display text }
--"Disable*"/"Force*Off" keys are shown as the feature itself, so their values are inverted.
local mEffectEntries =
{
    { "EnableRelighting", "Relighting", ON_OFF, LABELS_ON_OFF },
    { "EnableColorGrading", "Color Grading", ON_OFF, LABELS_ON_OFF },
    { "EnableLensFlare", "Lens Flare", ON_OFF, LABELS_ON_OFF },
    { "VolumetricQuality", "Volumetric Lighting", { 0, 1, 2, 3, 4 }, { "Off", "Low", "Medium", "High", "Ultra (slow)" }, true },
    { "EnableDepthOfField", "Depth of Field Autofocus", ON_OFF, LABELS_ON_OFF },
    { "HighQualityDepthOfField", "High Quality Depth of Field", ON_OFF, LABELS_ON_OFF },
    { "EnableMotionBlur", "Motion Blur", ON_OFF, LABELS_ON_OFF },
};

local mCinematicEntries =
{
    { "DisableFog", "Fog", OFF_ON, LABELS_ON_OFF },
    { "CinematicMode", "Letterbox", ON_OFF, LABELS_ON_OFF },
    { "BlackAndWhiteMode", "Black and White", ON_OFF, LABELS_ON_OFF },
    { "ForceVignetteOff", "Vignette", OFF_ON, LABELS_ON_OFF },
    { "ForceBloomOff", "Bloom", OFF_ON, LABELS_ON_OFF },
    { "DisableOutlines", "Comic Outlines", OFF_ON, LABELS_ON_OFF },
    { "FOVMultiplier", "Field of View", { 0.8, 0.9, 1.0, 1.1, 1.2, 1.3 }, { "80%", "90%", "100%", "110%", "120%", "130%" }, true },
    { "RenderScale", "Render Scale", { 0.75, 1.0, 1.25, 1.5, 2.0 }, { "75%", "100%", "125%", "150%", "200%" }, true },
};

local mConfig = nil;
local mbDirty = false;

local LoadConfig = function()
    local file = io.open(RELIGHT_MENU_ConfigFileName, "r");

    if file ~= nil then
        file:close();
        local ok, data = pcall(TLSE_INI_LoadINIFile, RELIGHT_MENU_ConfigFileName);

        if ok and data["Version"] and data["Version"]["ConfigurationVersion"] == RELIGHT_MENU_ConfigurationVersion and data["Global"] then
            return data;
        end
    end

    --Missing or older file: start from the defaults, like the relight backend does.
    return RELIGHT_GenerateNewINI_Main(RELIGHT_MENU_ConfigurationVersion);
end

local SaveConfig = function()
    if not mbDirty then
        return;
    end

    pcall(TLSE_INI_SaveINIFile, RELIGHT_MENU_ConfigFileName, mConfig);
    mbDirty = false;

    --In a scene (pause menu) the backend already loaded its copy; keep it in sync for the per-frame checks.
    if RelightConfigGlobal ~= nil then
        for key, value in pairs(mConfig["Global"]) do
            RelightConfigGlobal[key] = value;
        end
    end
end

--Closest entry in the value list, so a hand-edited .ini value (for example FOV 1.15) still shows.
local NearestValue = function(values, value)
    local best = values[1];

    for _, candidate in ipairs(values) do
        if candidate == value then
            return candidate;
        end

        if type(value) == "number" and type(candidate) == "number" and math.abs(candidate - value) < math.abs(best - value) then
            best = candidate;
        end
    end

    return best;
end

function Menu_Relight_IsAvailable()
    return mbLibrariesLoaded;
end

local OpenPage = function(string_title, entries, bLinkCinematic)
    local menu = Menu_Create(Menu_Settings, "ui_menuSettingsGraphics");
    menu.align = "left";

    function menu:Hide(intDirection)
        SaveConfig();
        Menu.Hide(self);
    end

    function menu:Populate()
        Menu_Add(Header, nil, string_title);

        if AgentExists("ui_menuMain_buttonBack") then
            AgentHide("ui_menuMain_buttonBack", false);
            AgentSetProperty("ui_menuMain_buttonBack", "Button - Command", "Menu_Pop()");
        end

        if bLinkCinematic then
            Menu_Add(ListButton, "relight_cinematic", "Cinematic Look", "Menu_Relight_Cinematic()");
        end

        for _, entry in ipairs(entries) do
            local key, label, values, displayValues, bLiteral = entry[1], entry[2], entry[3], entry[4], entry[5];
            local toggle = Menu_Add(ListToggle, "relight_" .. key, label, nil, values, displayValues, nil, true);
            toggle.literalText = bLiteral;

            function toggle:SetValue(value)
                UI_Setting.SetValue(self, value);

                if mConfig["Global"][key] ~= value then
                    mConfig["Global"][key] = value;
                    mbDirty = true;
                    SaveConfig();

                    if key == "RenderScale" then
                        RenderSetScale(value);
                    end
                end
            end

            UI_Setting.SetValue(toggle, NearestValue(values, mConfig["Global"][key]));
        end

        if not IsPlatformSmallScreen() then
            Legend_Add("faceButtonRight", "legend_previousMenu", "Menu_Pop()");
            local legendWidget = Menu_Add(Legend);

            function legendWidget:Place()
                self:AnchorToAgent(menu.agent, "left", "bottom");
            end

            local legendButton = Menu_Add(LegendButtonBack, "legendButton_back", "Menu_Pop()", "legendButton_back");

            function legendButton:Place()
                self:AnchorToAgent(menu.agent, "left", "bottom");
            end
        end
    end

    Menu_Push(menu);
end

function Menu_Relight()
    mConfig = LoadConfig();
    mbDirty = false;
    OpenPage("Relight", mEffectEntries, true);
end

function Menu_Relight_Cinematic()
    OpenPage("Cinematic Look", mCinematicEntries, false);
end
