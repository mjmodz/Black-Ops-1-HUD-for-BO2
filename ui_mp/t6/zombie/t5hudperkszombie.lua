CoD.Perks = {}

CoD.Perks.IconSize = 36
CoD.Perks.Spacing = 12
CoD.Perks.LeftStart = 2
CoD.Perks.TopStart = 580
CoD.Perks.STATE_NOTOWNED = 0
CoD.Perks.STATE_OWNED = 1
CoD.Perks.STATE_PAUSED = 2
CoD.Perks.STATE_TBD = 3
CoD.Perks.PulseDuration = 200
CoD.Perks.PulseScale = 1.3
CoD.Perks.PausedAlpha = 0.3

CoD.Perks.ClientFieldNames = {
	{
		clientFieldName = "perk_additional_primary_weapon",
		material = RegisterMaterial("uie_perk_mulekick")
	},
	{
		clientFieldName = "perk_dead_shot",
		material = RegisterMaterial("uie_perk_deadshot")
	},
	{
		clientFieldName = "perk_dive_to_nuke",
		material = RegisterMaterial("uie_perk_phd")
	},
	{
		clientFieldName = "perk_double_tap",
		material = RegisterMaterial("uie_perk_doubletap")
	},
	{
		clientFieldName = "perk_juggernaut",
		material = RegisterMaterial("uie_perk_juggernog")
	},
	{
		clientFieldName = "perk_marathon",
		material = RegisterMaterial("uie_perk_staminup")
	},
	{
		clientFieldName = "perk_quick_revive",
		material = RegisterMaterial("uie_perk_revive")
	},
	{
		clientFieldName = "perk_sleight_of_hand",
		material = RegisterMaterial("uie_perk_speedcola")
	},
	{
		clientFieldName = "perk_tombstone",
		material = RegisterMaterial("uie_perk_tombstone")
	},
	{
		clientFieldName = "perk_chugabud",
		material = RegisterMaterial("uie_perk_who")
	},
	{
		clientFieldName = "perk_electric_cherry",
		material = RegisterMaterial("uie_perk_electric_cherry")
	},
	{
		clientFieldName = "perk_vulture",
		material = RegisterMaterial("uie_perk_vulture")
	}
}

local function FindPerkInfo(perkName)
	for i = 1, #CoD.Perks.ClientFieldNames do
		if CoD.Perks.ClientFieldNames[i].clientFieldName == perkName then
			return CoD.Perks.ClientFieldNames[i]
		end
	end

	return nil
end

local function GetMaterial(perkName)
	local perkInfo = FindPerkInfo(perkName)
	if perkInfo ~= nil then
		return perkInfo.material
	end

	return nil
end

local function GetFirstOpenWidget(menu)
	for i = 1, #menu.perks do
		if menu.perks[i].perkId == nil then
			return menu.perks[i]
		end
	end

	return nil
end

local function ClearWidget(widget)
	widget.perkId = nil
	widget.perkIcon:setAlpha(0)
end

local function SetWidgetPerk(widget, perkName)
	local material = GetMaterial(perkName)
	if material == nil then
		return
	end

	widget.perkId = perkName
	widget.perkIcon:setImage(material)
	widget.perkIcon:setAlpha(1)
end

local function PulseWidget(widget, alpha)
	widget:beginAnimation("pulse", CoD.Perks.PulseDuration)
	widget:setScale(CoD.Perks.PulseScale)
	widget.perkIcon:beginAnimation("pulse", CoD.Perks.PulseDuration)
	widget.perkIcon:setAlpha(alpha or 1)
end

local function RemovePerkIcon(menu, startIndex)
	for i = startIndex, #menu.perks do
		local current = menu.perks[i]
		local nextWidget = menu.perks[i + 1]

		if nextWidget ~= nil and nextWidget.perkId ~= nil then
			current.perkId = nextWidget.perkId
			current.perkIcon:setImage(GetMaterial(nextWidget.perkId))
			current.perkIcon:setAlpha(nextWidget.perkIcon.m_currentAnimationState and nextWidget.perkIcon.m_currentAnimationState.alpha or 1)
		else
			ClearWidget(current)
			break
		end
	end
end

LUI.createMenu.PerksArea = function(controller)
	local menu = CoD.Menu.New("PerksArea")
	menu:setOwner(controller)
	menu:setLeftRight(true, true, 0, 0)
	menu:setTopBottom(true, true, 0, 0)
	menu:setAlpha(1)
	menu.visible = true
	menu.perks = {}

	for i = 1, #CoD.Perks.ClientFieldNames do
		local left = CoD.Perks.LeftStart + ((CoD.Perks.IconSize + CoD.Perks.Spacing) * (i - 1))
		local right = left + CoD.Perks.IconSize

		local widget = LUI.UIElement.new()
		widget:setLeftRight(true, false, left, right)
		widget:setTopBottom(true, false, CoD.Perks.TopStart, CoD.Perks.TopStart + CoD.Perks.IconSize)
		widget:setScale(1)
		widget.perkId = nil

		local perkIcon = LUI.UIImage.new()
		perkIcon:setLeftRight(true, true, 0, 0)
		perkIcon:setTopBottom(true, true, 0, 0)
		perkIcon:setAlpha(0)
		widget:addElement(perkIcon)
		widget.perkIcon = perkIcon

		widget:registerEventHandler("transition_complete_pulse", CoD.Perks.IconPulseFinish)
		menu:addElement(widget)
		menu.perks[i] = widget
		menu:registerEventHandler(CoD.Perks.ClientFieldNames[i].clientFieldName, CoD.Perks.Update)
	end

	menu:registerEventHandler("hud_update_refresh", CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_PLAYER_IN_AFTERLIFE, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_PLAYER_DEAD, CoD.Perks.UpdateVisibility)
	menu:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.Perks.UpdateVisibility)

	return menu
end

CoD.Perks.UpdateVisibility = function(menu, event)
	local controller = event.controller
	if UIExpression.IsVisibilityBitSet(controller, CoD.BIT_HUD_VISIBLE) == 1
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IS_PLAYER_IN_AFTERLIFE) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_EMP_ACTIVE) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IN_VEHICLE) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IN_GUIDED_MISSILE) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_AMMO_COUNTER_HIDE) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IS_FLASH_BANGED) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_UI_ACTIVE) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_SCOREBOARD_OPEN) == 0
		and UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IS_SCOPED) == 0
		and (not CoD.IsShoutcaster(controller) or CoD.ExeProfileVarBool(controller, "shoutcaster_scorestreaks") and Engine.IsSpectatingActiveClient(controller))
		and CoD.FSM_VISIBILITY(controller) == 0 then
		if menu.visible ~= true then
			menu:setAlpha(1)
			menu.m_inputDisabled = nil
			menu.visible = true
		end
	elseif menu.visible == true then
		menu:setAlpha(0)
		menu.m_inputDisabled = true
		menu.visible = nil
	end

	menu:dispatchEventToChildren(event)
end

CoD.Perks.Update = function(menu, event)
	if GetMaterial(event.name) == nil then
		return
	end

	if event.newValue == CoD.Perks.STATE_OWNED then
		for i = 1, #menu.perks do
			local widget = menu.perks[i]
			if widget.perkId == event.name then
				PulseWidget(widget, 1)
				return
			end
		end

		local openWidget = GetFirstOpenWidget(menu)
		if openWidget ~= nil then
			SetWidgetPerk(openWidget, event.name)
		end
	elseif event.newValue == CoD.Perks.STATE_NOTOWNED then
		for i = 1, #menu.perks do
			if menu.perks[i].perkId == event.name then
				RemovePerkIcon(menu, i)
				return
			end
		end
	elseif event.newValue == CoD.Perks.STATE_PAUSED then
		for i = 1, #menu.perks do
			local widget = menu.perks[i]
			if widget.perkId == event.name then
				PulseWidget(widget, CoD.Perks.PausedAlpha)
				return
			end
		end
	end
end

CoD.Perks.IconPulseFinish = function(widget, event)
	if event.interrupted ~= true then
		widget:beginAnimation("pulse_done", CoD.Perks.PulseDuration)
		widget:setScale(1)
	end
end
