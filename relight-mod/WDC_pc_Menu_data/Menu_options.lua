--Menu_options.lua from WDC_pc_Menu_data.ttarch2 (decompiled with unluac), with the RELIGHT changes marked below.
require("Utilities.lua")
require("UI_ListButtonLite.lua")
require("UI_ListToggle.lua")
require("UI_ListSlider.lua")
require("UI_Popup.lua")
require("Menu_Controls.lua")
require("Menu_Gamma.lua")
require("Menu_Credits.lua")
require("UI_Header.lua")
require("UI_TooltipDisplay.lua")
require("Menu_ListMenu.lua")
require("MenuUtils.lua")
require("CrowdPlay.lua")
require("CrowdPlayOverlay.lua")
require("Menu_CrowdPlayMessaging.lua")
require("Menu_Partners.lua")
require("Menu_Languages.lua")
require("Menu_About.lua")
require("Menu_Extras.lua")
--RELIGHT: Options > Audio/Display > Relight submenu
require("Menu_Relight.lua")
local mbPopupShowing = false
local mCrowdPlayRestoreValues = {}
local mResolutionButton
local mbNetworkBlocking = false
Menu_Settings = Class(ListMenu)
if IsToolBuild() and IsPlatformAndroid() then
  function PlatformVideoRecordingReady()
    return Utilities_PlatformGetPurchaseProvider() ~= "Amazon"
  end
end

function Menu_Settings:AddWidget(widget, bAgentExists)
  ListMenu.AddWidget(self, widget, bAgentExists)
  if (IsClass(widget, UI_Setting) or IsClass(widget, ListSlider)) and widget.prefKey and not Settings_IsDirty(widget.prefKey) then
    widget:SetValue(PropertyGet(GetPreferences(), widget.prefKey))
  end
  return widget
end

local getResolutions = function()
  local txts = {}
  local resolutions = {}
  local currentResolution = GetPreferences().Windowed and GetPreferences()["Window Size"] or GetPreferences()["Fullscreen Size"]
  local found = false
  local all = RenderGetDisplayResolutions()
  local sortFunc = function(a, b)
    if a.x == b.x then
      return a.y < b.y
    else
      return a.x < b.x
    end
  end
  table.sort(all, sortFunc)
  for i, v in ipairs(all) do
    if v.x >= 800 and v.y >= 600 then
      table.insert(resolutions, v)
      table.insert(txts, v.x .. "x" .. v.y)
      if v.x == currentResolution.x and v.y == currentResolution.y then
        found = true
      end
    end
  end
  if not found then
    for i, v in ipairs(resolutions) do
      if v.x > currentResolution.x or v.x == currentResolution.x and v.y > currentResolution.y then
        table.insert(resolutions, i, currentResolution)
        table.insert(txts, i, currentResolution.x .. "x" .. currentResolution.y)
        found = true
        break
      end
    end
    if not found then
      table.insert(resolutions, currentResolution)
      table.insert(txts, currentResolution.x .. "x" .. currentResolution.y)
    end
  end
  return resolutions, txts
end

function Options_PopupShowing()
  return mbPopupShowing
end

function Options_ApplySettings(bPopMenu)
  mbPopupShowing = false
  Settings_Commit()
  if CrowdPlay_IsEnabled() then
    CrowdPlayOverlay_Update()
  end
  CreateEventLogEvent("CrowdPlay Decision Authority", GetPreferences()["Crowd Play - Host Makes Choice"] and "host" or "crowd", true)
  if bPopMenu then
    Menu_Pop()
  end
end

function Options_RestoreSettings(bPopMenu)
  mbPopupShowing = false
  Settings_Revert()
  if CrowdPlay_IsEnabled() then
    local prefs = GetPreferences()
    for k, v in pairs(mCrowdPlayRestoreValues) do
      prefs[k] = mCrowdPlayRestoreValues[k]
    end
    SavePrefs()
    CrowdPlayOverlay_Update()
  end
  CreateEventLogEvent("CrowdPlay Decision Authority", GetPreferences()["Crowd Play - Host Makes Choice"] and "host" or "crowd", true)
  if bPopMenu then
    Menu_Pop()
  end
end

function Options_ExitSettings(bPopMenu)
  if bPopMenu == nil then
    bPopMenu = true
  end
  local resolutionDirty = Settings_IsDirty("Window Size")
  local ps4DisplayDirty = Settings_IsDirty("Use PS4 On PC")
  if resolutionDirty then
    local confirmCommand, cancelCommand
    if bPopMenu then
      confirmCommand = "Options_ApplySettings(true)"
      cancelCommand = "Options_RestoreSettings(true)"
    else
      confirmCommand = "Options_ApplySettings(false)"
      cancelCommand = "Options_RestoreSettings(false)"
    end
    mbPopupShowing = true
    UI_Confirm("popup_settingsconfirm_header", "popup_settingsconfirm_message", confirmCommand, cancelCommand, "label_apply", "label_restore")
  elseif ps4DisplayDirty then
    local confirmCommand, cancelCommand
    if bPopMenu then
      confirmCommand = "Options_ApplySettings(true); SubProject_Switch('Menu', 'Menu_Main.lua')"
      cancelCommand = "Options_RestoreSettings(true)"
    else
      confirmCommand = "Options_ApplySettings(false); SubProject_Switch('Menu', 'Menu_Main.lua')"
      cancelCommand = "Options_RestoreSettings(false)"
    end
    mbPopupShowing = true
    UI_Confirm("popup_confirmIconStyle_header", "popup_confirmIconStyle_body", confirmCommand, cancelCommand, "label_apply", "label_restore")
  else
    Options_ApplySettings(bPopMenu)
  end
end

function Menu_Options()
  local menu = Menu_Create(ListMenu, "ui_menuSettings")
  if AgentExists("ui_menuPause.scene") and IsPlatformSmallScreen() then
    menu.align = "center"
  else
    menu.align = "left"
  end
  menu.background = {}
  menu.bMenuProject = SubProject_GetCurrent() == "Menu"
  mCrowdPlayRestoreValues = {}
  
  function menu:Show(intDirection)
    if intDirection ~= nil and 0 < intDirection then
      if self.bMenuProject then
        Menu_Main_SetIdle("env_clementineHouse400_settings")
        ChorePlayAndWait("env_clementineHouse400_mainMenuToSettings")
        ChorePlay("ui_alphaGradient_show")
      elseif AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionPauseSettingsIn")
      else
        ChorePlay("ui_keyArt_transitionMainSettingsIn")
      end
    end
    Menu.Show(self)
  end
  
  function menu:Hide(intDirection)
    Menu.Hide(self)
    if intDirection ~= nil and intDirection < 0 then
      if self.bMenuProject then
        ChorePlay("ui_alphaGradient_hide")
        ChorePlayAndWait("env_clementineHouse400_settingsToMainMenu")
      elseif AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionPauseSettingsOut")
      else
        ChorePlay("ui_keyArt_transitionMainSettingsOut")
      end
    end
  end
  
  function menu:Layout(widgets)
    ListMenu.Layout(self, widgets)
    local menuHeight = AgentGetProperty(self.agent, "Extents Max").y - AgentGetProperty(self.agent, "Extents Min").y
    local initialWidgetAgent = widgets[1].agent
    local intialWidgetWidth = AgentGetProperty(initialWidgetAgent, "Extents Max").x - AgentGetProperty(initialWidgetAgent, "Extents Min").x
    local initialWidgetHeight = AgentGetProperty(initialWidgetAgent, "Extents Max").y - AgentGetProperty(initialWidgetAgent, "Extents Min").y
    local columnSupportedCount = math.floor(menuHeight / initialWidgetHeight)
    local numWidgets = table.getn(widgets)
    if columnSupportedCount < numWidgets then
      local eventSplitCount = math.ceil(numWidgets / 2)
      local initialWidgetPos = AgentGetPos(initialWidgetAgent)
      for i = eventSplitCount + 1, numWidgets do
        local widgetAgent = widgets[i].agent
        local widgetHeight = AgentGetProperty(widgetAgent, "Extents Max").y - AgentGetProperty(widgetAgent, "Extents Min").y
        AgentSetPos(widgetAgent, Vector(initialWidgetPos.x + intialWidgetWidth, initialWidgetPos.y - widgetHeight * (i - (eventSplitCount + 1)), 0))
      end
    end
  end
  
  function menu:Populate()
    if IsPlatformSmallScreen() and not AgentExists("ui_menuPause.scene") then
      local optionHeader = Menu_Add(Header, nil, "header_extrasAndSettings")
      
      function optionHeader:Place()
        self:AnchorToAgent(menu.agent, "center", "top")
      end
    else
      Menu_Add(Header, nil, "header_settings")
    end
    if IsPlatformSmallScreen() and not AgentExists("ui_menuPause.scene") then
      if AgentExists("ui_menuMain_buttonBack") then
        AgentHide("ui_menuMain_buttonBack", false)
        AgentSetProperty("ui_menuMain_buttonBack", "Button - Command", "Menu_Pop()")
      end
      if (IsPlatformXbox360() or IsPlatformXboxOne() or IsPlatformAndroid() and Utilities_PlatformGetPurchaseProvider() ~= "Amazon") and MenuUtils_PlatformIsUserSignedIn() then
        Menu_Add(ListButtonLite, "achievements", "label_achievements", "PlatformOpenAchievementUI()")
      end
      local statsButton = Menu_Add(ListButton, "stats", "label_relationshipsAndChoices", "Menu_Extras_Stats()")
      local bLocked = ChoiceStats_IsEmpty() or not IsLicensed()
      local tooltip = bLocked and "tooltip_lockedRelationshipsAndChoices" or ""
      statsButton:SetTooltip(tooltip)
      statsButton:SetIsLocked(bLocked)
      if not bLocked then
        statsButton:SetIsNew(ChoiceStats_IsNew())
      end
      Menu_Add(ListButtonLite, "credits", "label_credits", "Menu_Credits()")
    elseif IsPlatformSmallScreen() and AgentExists("ui_legendButton_backBig") then
      AgentHide("ui_legendButton_backBig", false)
      AgentSetProperty("ui_legendButton_backBig", "Button - Command", "Menu_Pop()")
    end
    if not self.bMenuProject then
      if not AgentExists("ui_menuPause.scene") and IsLicensed() and PlatformIsUserSpaceAvailable() then
        Menu_Add(ListButtonLite, "savesFiles", "label_saveFiles", "Menu_Saves()")
      end
      Menu_Add(ListButtonLite, "controls", "label_controls", "Menu_Controls()")
    end
    Menu_Add(ListButtonLite, "audioDisplay", "label_audiodisplay", "Menu_AudioDisplay()")
    if not AgentExists("ui_menuPause.scene") then
      Menu_Add(ListButtonLite, "language", "label_languages", "Menu_Languages()")
    end
    if not self.bMenuProject then
      if not IsPlatformIOS() and not IsPlatformAndroid() then
        Menu_Add(ListButtonLite, "gameplay", "label_gameplay", "Menu_Gameplay()")
      end
      if CrowdPlay_IsSupported() then
        Menu_Add(ListButtonLite, "crowdplay", "label_crowdPlay", "Menu_CrowdPlayOptions()")
      end
    end
    Menu_Add(ListButtonLite, "about", "label_about", "Menu_About()")
    local legendWidget = Menu_Add(Legend)
    
    function legendWidget:Place()
      self:AnchorToAgent(menu.agent, "left", "bottom")
    end
    
    Legend_Add("faceButtonDown", "legend_select")
    if IsPlatformXboxOne() then
      Legend_Add("faceButtonUp", MenuUtils_LegendStringForProfileUser(Menu_Text("legend_changeProfile")), "PlatformOpenAccountPickerUI()")
    end
    Legend_Add("faceButtonRight", "legend_previousMenu", "Menu_Pop()")
    if not IsPlatformSmallScreen() then
      local legendButton = Menu_Add(LegendButtonBack, "legendButton_back", "Menu_Pop()", "legendButton_back")
      
      function legendButton:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
    end
  end
  
  function menu:OnWidgetInputChange(bUseCursor)
    if bUseCursor then
      ChorePlay("ui_popupSave_legendBackingHide.chore")
    else
      ChorePlay("ui_popupSave_legendBackingShow.chore")
    end
  end
  
  Menu_Push(menu)
end

local Menu_AudioDisplay_ShowDisableLicensedMusic = function()
  return false
end

function Menu_AudioDisplay()
  local menu = Menu_Create(Menu_Settings, "ui_menuSettingsAudioDisplay")
  if AgentExists("ui_menuPause.scene") and IsPlatformSmallScreen() then
    menu.align = "center"
  else
    menu.align = "left"
  end
  menu.background = {}
  local OnLicensedMusicChange = function(key, val)
    if key == "Licensed Music" then
      if val then
        if AgentExists("audioScene_musicInterfaceaudio") then
          AgentSetProperty("audioScene_musicInterfaceaudio", "Sound Music - Licensed Music", 0)
        end
        if AgentExists("audio_music_interface_ui_menuMain") then
          AgentSetProperty("audio_music_interface_ui_menuMain", "Sound Music - Licensed Music", 0)
        end
      else
        if AgentExists("audioScene_musicInterfaceaudio") then
          AgentSetProperty("audioScene_musicInterfaceaudio", "Sound Music - Licensed Music", 1)
        end
        if AgentExists("audio_music_interface_ui_menuMain") then
          AgentSetProperty("audio_music_interface_ui_menuMain", "Sound Music - Licensed Music", 1)
        end
      end
    end
  end
  local OnWindowSizeChange = function(key, val)
    menu:Refresh()
    if not IsPlatformWin10() then
      local resAgent = AgentFind("ui_menuSettingsAudioDisplay_resolution")
      if resAgent then
        local resWidget = resAgent.widget
        resWidget.initCalled = false
        resWidget:InitValue()
        resWidget:Update()
        local settingToSet
        if key == "Windowed" then
          settingToSet = "Windowed"
        elseif key == "Window Size" then
          settingToSet = "Window Size"
        else
          settingToSet = "Fullscreen Size"
        end
        Settings_Set(settingToSet, val)
      end
    end
  end
  local prefs = GetPreferences()
  
  function menu:Show(intDirection)
    if intDirection ~= nil and 0 < intDirection then
      local eventLogData
      if AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionSettingsSubMenusIn.chore")
        eventLogData = "Audio/Display Pause"
      else
        ChorePlay("ui_keyArt_transitionSettingsSubMenusIn.chore")
        eventLogData = "Audio/Display Main Menu"
      end
      CreateEventLogEvent("Setting Menu Page Shown", eventLogData, true)
    end
    Menu.Show(self)
    PropertyAddKeyCallback(prefs, "Fullscreen Size", OnWindowSizeChange)
    PropertyAddKeyCallback(prefs, "Window Size", OnWindowSizeChange)
    PropertyAddKeyCallback(prefs, "Windowed", OnWindowSizeChange)
    PropertyAddKeyCallback(prefs, "Licensed Music", OnLicensedMusicChange)
  end
  
  function menu:Hide(intDirection)
    PropertyRemoveKeyCallback(prefs, "Fullscreen Size", OnWindowSizeChange)
    PropertyRemoveKeyCallback(prefs, "Window Size", OnWindowSizeChange)
    PropertyRemoveKeyCallback(prefs, "Windowed", OnWindowSizeChange)
    PropertyRemoveKeyCallback(prefs, "Licensed Music", OnLicensedMusicChange)
    if not IsPlatformWin10() and mResolutionButton ~= nil then
      local resAgent = AgentFind("ui_menuSettingsAudioDisplay_resolution")
      if resAgent then
        local resWidget = resAgent.widget
        resWidget.initCalled = false
      end
    end
    Menu.Hide(self)
    if intDirection ~= nil and intDirection < 0 then
      if AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionSettingsSubMenusOut.chore")
      else
        ChorePlay("ui_keyArt_transitionSettingsSubMenusOut.chore")
      end
    end
  end
  
  function menu:Populate()
    local audioHeader = Menu_Add(Header, nil, "header_audiodisplay")
    if IsPlatformSmallScreen() then
      function audioHeader:Place()
        self:AnchorToAgent(menu.agent, "center", "top")
      end
    end
    if AgentExists("ui_menuMain_buttonBack") then
      AgentHide("ui_menuMain_buttonBack", false)
      AgentSetProperty("ui_menuMain_buttonBack", "Button - Command", "Options_ExitSettings()")
    end
    Menu_Add(ListSlider, "master", "label_volume_master", "Volume Master", "tooltip_volumeMaster")
    Menu_Add(ListSlider, "music", "label_volume_music", "Volume Music", "tooltip_volumeMusic")
    if (IsPlatformPC() or IsPlatformPS4() or IsPlatformXboxOne()) and Menu_AudioDisplay_ShowDisableLicensedMusic() then
      Menu_Add(ListToggle, "disableLicensedMusic", "label_disableLicensedMusic", "Licensed Music", "inverted", nil, "tooltip_disableLicensedMusic", true)
    end
    Menu_Add(ListToggle, "subtitles", "label_subtitles", "Enable Subtitles", nil, nil, "tooltip_subtitles")
    local subTitleSizes = {
      0,
      0.5,
      1
    }
    local subTitleLabels = {
      "label_small",
      "label_medium",
      "label_large"
    }
    if IsPlatformAndroid() and Utilities_PlatformGetGPUQuality() == 0 then
      subTitleSizes = {0.5, 1}
      subTitleLabels = {
        "label_small",
        "label_large"
      }
    end
    self.lastNonResizableWidget = Menu_Add(ListToggle, "subtitleSize", "label_subtitleSize", "Subtitle Size", subTitleSizes, subTitleLabels, "tooltip_subtitleSize")
    if IsPlatformPC() or IsPlatformMac() then
      self.lastNonResizableWidget = Menu_Add(ListToggle, "windowed", "label_windowed", "Windowed", "inverted", nil, "tooltip_fullScreen", true)
      if not IsPlatformWin10() then
        local resValues, resDisplay = getResolutions()
        local res = Menu_Add(ListSlider, "resolution", "label_resolution", nil, "tooltip_resolution")
        res.minValue = 1
        res.maxValue = table.getn(resValues)
        res.incrementStep = 1
        res.snappingEnabled = true
        self.lastNonResizableWidget = res
        local setRes = function(res, value)
          local index = math.min(math.max(res.minValue, math.floor(value + 0.5)), res.maxValue)
          res.value = index
          Settings_Set("Window Size", resValues[index])
          Settings_Set("Fullscreen Size", resValues[index])
          WaitForNextFrame()
        end
        
        function res:InitValue()
          if not self.initCalled then
            self.initCalled = true
            local currentResolution = GetPreferences().Windowed and GetPreferences()["Window Size"] or GetPreferences()["Fullscreen Size"]
            local currentResolutionIndex
            for i, v in ipairs(resValues) do
              if currentResolution.x == v.x and currentResolution.y == v.y then
                currentResolutionIndex = i
                break
              end
            end
            setRes(self, currentResolutionIndex)
          end
        end
        
        function res:SetValue(value)
          setRes(self, value)
          UI_Setting.SetValue(self, value)
        end
        
        function res:DisplayValue(value)
          local index = math.min(math.max(self.minValue, math.floor(value + 0.5)), self.maxValue)
          return resDisplay[index]
        end
        
        res:InitValue()
        res:SetValue(res.value)
        mResolutionButton = res
      end
    end
    if not IsPlatformIOS() and not IsPlatformAndroid() and not IsPlatformVita() then
      self.gammaButtonWidget = Menu_Add(ListButton, "gamma", "label_gamma", "Menu_Gamma()", "tooltip_gamma")
      local buttonAgent = Clone_Find(self.gammaButtonWidget.agent, "_button")
      
      function buttonAgent:ShowSelect(button, event)
        Legend_Clear()
        Legend_Add("faceButtonDown", "legend_select")
        Legend_Add("faceButtonRight", "legend_previousMenu", "Options_ExitSettings()")
      end
      
      function buttonAgent:ShowDeselect(button, event)
        Legend_Clear()
        Legend_Add("faceButtonRight", "legend_previousMenu", "Options_ExitSettings()")
      end
      
      AgentSetProperty(buttonAgent, "D3D Mesh", "ui_listButton_wideBackground.d3dmesh")
      
      function self.gammaButtonWidget:Place()
      end
    end
    if IsPlatformPC() or IsPlatformMac() then
      self.graphicsButtonWidget = Menu_Add(ListButton, "graphics", "label_graphics", "Menu_Graphics()")
      local buttonAgent = Clone_Find(self.graphicsButtonWidget.agent, "_button")
      if buttonAgent then
        AgentSetProperty(buttonAgent, "D3D Mesh", "ui_listButton_wideBackground.d3dmesh")
      end
      --RELIGHT: one extra button under Graphics
      if Menu_Relight_IsAvailable() then
        self.relightButtonWidget = Menu_Add(ListButton, "relight", "Relight", "Menu_Relight()")
        local relightButtonAgent = Clone_Find(self.relightButtonWidget.agent, "_button")
        if relightButtonAgent then
          AgentSetProperty(relightButtonAgent, "D3D Mesh", "ui_listButton_wideBackground.d3dmesh")
        end
      end
    end
    local tooltipDisplay = Menu_Add(TooltipDisplay, "tooltipDisplay", menu.align)
    tooltipDisplay.alignmentH = menu.align
    tooltipDisplay.alignmentV = "bottom"
    if not IsPlatformSmallScreen() then
      Legend_Add("faceButtonRight", "legend_previousMenu", "Options_ExitSettings()")
      local legendWidget = Menu_Add(Legend)
      
      function legendWidget:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
      
      local legendButton = Menu_Add(LegendButtonBack, "legendButton_back", "Options_ExitSettings()", "legendButton_back")
      
      function legendButton:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
    end
  end
  
  function menu:OnMenuButton(button, event)
    Options_ExitSettings()
  end
  
  function menu:Layout(widgets)
    ListMenu.Layout(self, widgets)
    local buttonsToResize = {
      self.gammaButtonWidget,
      self.graphicsButtonWidget,
      self.relightButtonWidget
    }
    local subTitlePos = AgentGetPos(self.lastNonResizableWidget.agent)
    local yOffset = subTitlePos.y
    for i, buttonWidget in ipairs(buttonsToResize) do
      local buttonWidgetExtentsMin = AgentGetProperty(buttonWidget.agent, "Extents Min")
      local buttonWidgetExtentsMax = AgentGetProperty(buttonWidget.agent, "Extents Max")
      local lastNonResizableExtentsMin = AgentGetProperty(self.lastNonResizableWidget.agent, "Extents Min")
      local lastNonResizableExtentsMax = AgentGetProperty(self.lastNonResizableWidget.agent, "Extents Max")
      local selfExtentsMin = AgentGetProperty(self.agent, "Extents Min")
      buttonWidgetExtentsMax.x = (lastNonResizableExtentsMax.x - lastNonResizableExtentsMin.x) / 2
      buttonWidgetExtentsMin.x = -((lastNonResizableExtentsMax.x - lastNonResizableExtentsMin.x) / 2)
      AgentSetProperty(buttonWidget.agent, "Extents Min", buttonWidgetExtentsMin)
      AgentSetProperty(buttonWidget.agent, "Extents Max", buttonWidgetExtentsMax)
      local agentPos = Vector(selfExtentsMin.x - buttonWidgetExtentsMin.x, yOffset - (lastNonResizableExtentsMax.y - lastNonResizableExtentsMin.y) / 2 - (buttonWidgetExtentsMax.y - buttonWidgetExtentsMin.y) / 2, subTitlePos.z)
      AgentSetPos(buttonWidget.agent, agentPos)
      yOffset = agentPos.y
      local buttonAgent = Clone_Find(buttonWidget.agent, "_button")
      AgentSetPos(buttonAgent, Vector(0, 0, 0))
      AgentSetProperty(buttonAgent, "Extents Min", buttonWidgetExtentsMin)
      AgentSetProperty(buttonAgent, "Extents Max", buttonWidgetExtentsMax)
      local buttonAgentSceneProps = AgentGetSceneProperties(buttonAgent)
      local minProps = PropertyGet(buttonAgentSceneProps, "Extents Min")
      local maxProps = PropertyGet(buttonAgentSceneProps, "Extents Max")
      if AgentHasProperty(buttonAgent, "Render Axis Scale") then
        local originalAgentWidth = maxProps.x - minProps.x + 0.05
        local scaleX = (buttonWidgetExtentsMax.x - buttonWidgetExtentsMin.x) / originalAgentWidth
        local agentScale = AgentGetProperty(buttonAgent, "Render Axis Scale")
        agentScale.x = scaleX
        AgentSetProperty(buttonAgent, "Render Axis Scale", agentScale)
      end
      AgentSetPos(Clone_Find(buttonWidget.agent, "_label"), Vector(buttonWidgetExtentsMin.x, 0, 0))
      local infoButton = Clone_Find(buttonWidget.agent, "_infoButton")
      if infoButton then
        local lastNonResizableInfoButton = Clone_Find(self.lastNonResizableWidget.agent, "_infoButton")
        if lastNonResizableInfoButton then
          AgentSetPos(infoButton, AgentGetPos(lastNonResizableInfoButton))
        else
          local infoExtentsMin = AgentGetProperty(infoButton, "Extents Min")
          AgentSetPos(infoButton, Vector(buttonWidgetExtentsMax.x - infoExtentsMin.x, 0, 0))
        end
      end
    end
  end
  
  Menu_Push(menu)
end

function Menu_Gameplay()
  local menu = Menu_Create(Menu_Settings, "ui_menuSettingsGameplay")
  if AgentExists("ui_menuPause.scene") and IsPlatformSmallScreen() then
    menu.align = "center"
  else
    menu.align = "left"
  end
  menu.background = {}
  
  function menu:Show(intDirection)
    if intDirection ~= nil and 0 < intDirection then
      local eventLogData
      if AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionSettingsSubMenusIn.chore")
        eventLogData = "Gameplay Pause"
      else
        ChorePlay("ui_keyArt_transitionSettingsSubMenusIn.chore")
        eventLogData = "Gameplay Main Menu"
      end
      CreateEventLogEvent("Setting Menu Page Shown", eventLogData, true)
    end
    Menu.Show(self)
  end
  
  function menu:Hide(intDirection)
    Menu.Hide(self)
    if intDirection ~= nil and intDirection < 0 then
      if AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionSettingsSubMenusOut.chore")
      else
        ChorePlay("ui_keyArt_transitionSettingsSubMenusOut.chore")
      end
    end
  end
  
  function menu:Populate()
    local optionHeader = Menu_Add(Header, nil, "header_gameplay")
    if IsPlatformSmallScreen() then
      function optionHeader:Place()
        self:AnchorToAgent(menu.agent, "center", "top")
      end
    end
    if AgentExists("ui_menuMain_buttonBack") then
      AgentHide("ui_menuMain_buttonBack", false)
      AgentSetProperty("ui_menuMain_buttonBack", "Button - Command", "Options_ExitSettings()")
    end
    Menu_Add(ListToggle, "invertY", "label_inverty", "Invert Joystick", nil, nil, "tooltip_invertY")
    local cameraSlider = Menu_Add(ListSlider, "cameraSpeed", "label_camera_speed", "Orbit Cam Speed", "tooltip_cameraSpeed")
    cameraSlider.incrementStep = 0.1
    cameraSlider.snappingEnabled = true
    
    function cameraSlider:DisplayValue(value)
      local value = value * 10 - 5
      return math.floor(value + 0.5)
    end
    
    cameraSlider:Update()
    if IsPlatformPC() and ResourceSetExists("PC_PS") then
      if AgentExists("ui_menuPause.scene") then
        local iconStyleToggle = Menu_Add(ListToggle, "flipPlaystationControls", "label_iconStyle", "Use PS4 On PC", "onOff", {
          "label_ps4",
          "label_xbone"
        })
        AgentSetProperty(iconStyleToggle.agent, "Button - Tooltip Lock", "tooltip_lockedIconStyle")
        iconStyleToggle:SetIsLocked(true)
      else
        Menu_Add(ListToggle, "flipPlaystationControls", "label_iconStyle", "Use PS4 On PC", "onOff", {
          "label_ps4",
          "label_xbone"
        }, "")
      end
    end
    if not IsPlatformSmallScreen() then
      Legend_Add("faceButtonRight", "legend_previousMenu", "Options_ExitSettings()")
      local legendWidget = Menu_Add(Legend)
      
      function legendWidget:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
      
      local legendButton = Menu_Add(LegendButtonBack, "legendButton_back", "Options_ExitSettings()", "legendButton_back")
      
      function legendButton:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
    end
    local tooltipDisplay = Menu_Add(TooltipDisplay, "tooltipDisplay", menu.align)
    tooltipDisplay.alignmentH = menu.align
    tooltipDisplay.alignmentV = "bottom"
  end
  
  Menu_Push(menu)
end

function Menu_Graphics()
  local menu = Menu_Create(Menu_Settings, "ui_menuSettingsGraphics")
  if AgentExists("ui_menuPause.scene") and IsPlatformSmallScreen() then
    menu.align = "center"
  else
    menu.align = "left"
  end
  local mHBAOToggle, mDOFToggle
  local OnRenderQualityChange = function(key, val)
    local settingToSet
    if key == "Render Quality" then
      if val == 3 then
        if mHBAOToggle then
          mHBAOToggle:SetValue(3)
          mHBAOToggle:SetIsLocked(true)
          mHBAOToggle:Update()
        end
        if mDOFToggle then
          mDOFToggle:SetValue(0)
          mDOFToggle:SetIsLocked(true)
          mDOFToggle:Update()
        end
      else
        if mHBAOToggle then
          mHBAOToggle:SetIsLocked(false)
          mHBAOToggle:Update()
        end
        if mDOFToggle then
          mDOFToggle:SetIsLocked(false)
          mDOFToggle:Update()
        end
      end
    end
  end
  local prefs = GetPreferences()
  
  function menu:Show(intDirection)
    if intDirection ~= nil and 0 < intDirection then
      local eventLogData
      if AgentExists("ui_menuPause.scene") then
        eventLogData = "Graphics Pause"
      else
        eventLogData = "Graphics Main Menu"
      end
      CreateEventLogEvent("Setting Menu Page Shown", eventLogData, true)
    end
    Menu.Show(self)
    PropertyAddKeyCallback(prefs, "Render Quality", OnRenderQualityChange)
  end
  
  function menu:Hide(intDirection)
    PropertyRemoveKeyCallback(prefs, "Render Quality", OnRenderQualityChange)
    Menu.Hide(self)
  end
  
  function menu:Populate()
    local optionHeader = Menu_Add(Header, nil, "header_graphics")
    if IsPlatformSmallScreen() then
      function optionHeader:Place()
        self:AnchorToAgent(menu.agent, "center", "top")
      end
    end
    if AgentExists("ui_menuMain_buttonBack") then
      AgentHide("ui_menuMain_buttonBack", false)
      AgentSetProperty("ui_menuMain_buttonBack", "Button - Command", "Options_ExitSettings()")
    end
    if not IsPlatformMac() then
      Menu_Add(ListToggle, "textureQuality", "label_textureQuality", "Texture Quality", {
        2,
        1,
        0
      }, {
        "label_low",
        "label_medium",
        "label_high"
      }, "tooltip_textureQuality", true)
    end
    PropertyAddKeyCallback(prefs, "Render Quality", function(key, val)
      RenderSetCurQualityLevel(val)
    end)
    if not IsPlatformMac() then
      Menu_Add(ListToggle, "renderQuality", "label_renderQuality", "Render Quality", {4, 9}, {"label_low", "label_high"}, "tooltip_renderQuality", true)
    end
    if IsDebugBuild() then
      if PropertyGet(GetPreferences(), "Render - HBAO Platform Preset") == 0 then
        PropertySet(GetPreferences(), "Render - HBAO Platform Preset", 5)
      end
      SavePrefs()
    end
    if not IsPlatformMac() then
      mHBAOToggle = Menu_Add(ListToggle, "hbaoQuality", "label_hbaoQuality", "Render - HBAO Platform Preset", {
        3,
        4,
        5,
        6,
        7
      }, {
        "label_off",
        "label_low",
        "label_medium",
        "label_high",
        "label_ultra"
      }, "tooltip_hbaoQuality", true)
      mDOFToggle = Menu_Add(ListToggle, "dofQuality", "label_dofQuality", "Render - DOF Quality", {
        0,
        1,
        2,
        3
      }, {
        "label_off",
        "label_low",
        "label_medium",
        "label_high"
      }, "tooltip_dofQuality", true)
      local bokehToggle = Menu_Add(ListToggle, "bokehQuality", "label_bokehQuality", "Render - Bokeh Quality", {
        0,
        2,
        3
      }, {
        "label_off",
        "label_low",
        "label_high"
      }, "tooltip_bokehQuality", true)
      AgentSetProperty(mHBAOToggle.agent, "Button - Tooltip Lock", "tooltip_hbaoLocked")
      AgentSetProperty(mDOFToggle.agent, "Button - Tooltip Lock", "tooltip_dofLocked")
      AgentSetProperty(bokehToggle.agent, "Button - Tooltip Lock", "tooltip_bokehLocked")
      local DOFQualityCallback = function(key, value)
        if PropertyGet(prefs, "Render - DOF Quality") == 0 then
          bokehToggle:SetValue(0)
          bokehToggle:SetIsLocked(true)
        else
          bokehToggle:SetIsLocked(false)
        end
      end
      OnRenderQualityChange("Render Quality", PropertyGet(prefs, "Render Quality"))
      DOFQualityCallback()
      PropertyAddKeyCallback(prefs, "Render - DOF Quality", DOFQualityCallback)
    end
    Menu_Add(ListToggle, "antialiasing", "label_antialiasing", "FX anti-aliasing", nil, nil, "tooltip_antialiasing", true)
    if not IsPlatformSmallScreen() then
      Legend_Add("faceButtonRight", "legend_previousMenu", "Options_ExitSettings()")
      local legendWidget = Menu_Add(Legend)
      
      function legendWidget:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
      
      local legendButton = Menu_Add(LegendButtonBack, "legendButton_back", "Options_ExitSettings()", "legendButton_back")
      
      function legendButton:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
    end
    local tooltipDisplay = Menu_Add(TooltipDisplay, "tooltipDisplay", menu.align)
    tooltipDisplay.alignmentH = menu.align
    tooltipDisplay.alignmentV = "bottom"
    AgentSetProperty(tooltipDisplay.agent, "Text Width", 11)
  end
  
  Menu_Push(menu)
end

function Menu_CrowdPlayOptions()
  local menu = Menu_Create(Menu_Settings, "ui_menuSettingsCrowdPlay")
  if AgentExists("ui_menuPause.scene") and IsPlatformSmallScreen() then
    menu.align = "center"
  else
    menu.align = "left"
  end
  menu.background = {}
  
  function menu:Show(intDirection)
    if intDirection ~= nil and 0 < intDirection then
      local eventLogData
      if AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionSettingsSubMenusIn.chore")
        eventLogData = "Crowdplay Pause"
      else
        ChorePlay("ui_keyArt_transitionSettingsSubMenusIn.chore")
        eventLogData = "Crowdplay Main Menu"
      end
      CreateEventLogEvent("Setting Menu Page Shown", eventLogData, true)
    end
    Menu.Show(self)
  end
  
  function menu:Hide(intDirection)
    Menu.Hide(self)
    if intDirection ~= nil and intDirection < 0 then
      if AgentExists("ui_menuPause.scene") then
        ChorePlay("ui_menuPause_transitionSettingsSubMenusOut.chore")
      else
        ChorePlay("ui_keyArt_transitionSettingsSubMenusOut.chore")
      end
    end
  end
  
  function menu:Populate()
    local optionHeader = Menu_Add(Header, nil, "header_CrowdPlay")
    if IsPlatformSmallScreen() then
      function optionHeader:Place()
        self:AnchorToAgent(menu.agent, "center", "top")
      end
    end
    if AgentExists("ui_menuMain_buttonBack") then
      AgentHide("ui_menuMain_buttonBack", false)
      AgentSetProperty("ui_menuMain_buttonBack", "Button - Command", "Options_ExitSettings()")
    end
    mCrowdPlayRestoreValues["Crowd Play - Host Makes Choice"] = mCrowdPlayRestoreValues["Crowd Play - Host Makes Choice"] or GetPreferences()["Crowd Play - Host Makes Choice"]
    mCrowdPlayRestoreValues["Crowd Play - Enable Overlay Info"] = mCrowdPlayRestoreValues["Crowd Play - Enable Overlay Info"] or GetPreferences()["Crowd Play - Enable Overlay Info"]
    Menu_Add(ListToggle, "authority", "label_crowdPlayWhoDecides", "Crowd Play - Host Makes Choice", {false, true}, {
      "label_crowdPlayCrowd",
      "label_crowdPlayHost"
    }, "tooltip_hostDecides")
    Menu_Add(ListToggle, "display", "label_displayRoomCode", "Crowd Play - Enable Overlay Info", nil, nil, "tooltip_displayRoomCode")
    if IsDebugBuild() and GetPreferences()["Beta Menu - Beta Test Crowd Play"] then
      local prefs = GetPreferences()
      local numControllers = prefs["Crowd Play - Num Controllers"] or 1
      if numControllers ~= 1 and numControllers ~= 4 and numControllers ~= 10 and numControllers ~= 20 then
        numControllers = 1
      end
      prefs["Crowd Play - Num Controllers"] = numControllers
      SavePrefs()
      Menu_Add(ListToggle, "numControllers", "Number of Controllers", "Crowd Play - Num Controllers", {
        1,
        4,
        10,
        20
      }, {
        "1",
        "4",
        "10",
        "20"
      }, "FOR TEST BUILDS ONLY; DOES NOT APPEAR IN RELEASE BUILDS.  The number of game-side controllers attached to the game during Crowd Play.  The game will fill in randomized votes as needed for any controllers not actually connected.")
    end
    if not IsPlatformSmallScreen() then
      Legend_Add("faceButtonRight", "legend_previousMenu", "Options_ExitSettings()")
      local legendWidget = Menu_Add(Legend)
      
      function legendWidget:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
      
      local legendButton = Menu_Add(LegendButtonBack, "legendButton_back", "Options_ExitSettings()", "legendButton_back")
      
      function legendButton:Place()
        self:AnchorToAgent(menu.agent, "left", "bottom")
      end
    end
    local tooltipDisplay = Menu_Add(TooltipDisplay, "tooltipDisplay", menu.align)
    tooltipDisplay.alignmentH = menu.align
    tooltipDisplay.alignmentV = "bottom"
  end
  
  Menu_Push(menu)
end
