--||||||||||||||||||||||||||||||||||||||| INI GENERATION - RELIGHT MAIN |||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||| INI GENERATION - RELIGHT MAIN |||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||| INI GENERATION - RELIGHT MAIN |||||||||||||||||||||||||||||||||||||||

--generates a new ini file
RELIGHT_GenerateNewINI_Main = function(number_configurationVersion)
    local data = 
    {
        Version = 
        {
            ConfigurationVersion = number_configurationVersion,
        },
        Global = 
        {
            FOVMultiplier = 1.0, 
            MotionBlurIntensity = 25.0,
            RenderScale = 1.0,
            DisableOutlines = true,
            DisablePostProcessing = false,
			DisableFog = false,
            CinematicMode = false,
            BlackAndWhiteMode = false,
            HighQualityDepthOfField = true,
            OverrideTimeScale = false,
            TimeScaleValue = 1,
            ForceGraphicBlackOff = true,
            ForceBloomOff = false,
            EnableMotionBlur = false,
            ForceVignetteOff = false,
            --Master switches, also set from the in-game Options > Relight menu. A level effect runs only
            --when both this switch and the level .ini switch are on.
            EnableRelighting = true,
            EnableDepthOfField = true,
            EnableVolumetricLighting = true,
            --0 off, 1 low (24 planes), 2 medium (48), 3 high (96), 4 ultra (256, original look, slow).
            VolumetricQuality = 0,
            EnableColorGrading = true,
            EnableLensFlare = true,
        },
    };
        
    return data;
end