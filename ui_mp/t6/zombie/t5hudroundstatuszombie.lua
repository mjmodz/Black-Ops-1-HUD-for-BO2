CoD.RoundStatus = {}
CoD.RoundStatus.FactionIconLeftOffset = -8
CoD.RoundStatus.FactionIconSize = 95
CoD.RoundStatus.RoundIconLeftOffset = 87
CoD.RoundStatus.LeftOffset = -8
CoD.RoundStatus.ChalkTop = -101
CoD.RoundStatus.ChalkSize = 95
CoD.RoundStatus.SpecialRoundIconSize = 85
CoD.RoundStatus.RoundCenterHeight = 80
CoD.RoundStatus.Chalks = {}
CoD.RoundStatus.FirstRoundDuration = 1000
CoD.RoundStatus.FirstRoundIdleDuration = 3000
CoD.RoundStatus.FirstRoundFallDuration = 2000
CoD.RoundStatus.RoundPulseDuration = 500
CoD.RoundStatus.RoundPulseTimes = 2
CoD.RoundStatus.RoundPulseTimesDelta = 5
CoD.RoundStatus.RoundPulseTimesMin = 2
CoD.RoundStatus.RoundMax = 100
CoD.RoundStatus.ChalkFontName = "Morris"
CoD.RoundStatus.RoundOneVisualCenterOffset = 36
local function SetT5Chalk1Bounds(chalk)
	chalk:setLeftRight(true, false, -8, 87)
	chalk:setTopBottom(false, true, -101, -6)
end

local function SetT5Chalk2Bounds(chalk)
	chalk:setLeftRight(true, false, 87, 182)
	chalk:setTopBottom(false, true, -101, -6)
end

local function GetTextWidthSafe(textValue, font, size)
	local dims = { GetTextDimensions(tostring(textValue), font, size) }

	if type(dims[1]) == "table" then
		return tonumber(dims[1][3]) or tonumber(dims[1].width) or 0
	end

	return tonumber(dims[3]) or tonumber(dims[1]) or 0
end

local function GetT5RoundCenterX(roundStatus)
	return (tonumber(roundStatus.safeAreaWidth) or 1280) * 0.5
end

local function SetT5RoundOneCenterBounds(roundStatus, chalk)
	local centerX = GetT5RoundCenterX(roundStatus) + CoD.RoundStatus.RoundOneVisualCenterOffset
	local roundOneWidth = 84

	chalk:setLeftRight(true, false, centerX - roundOneWidth * 0.5, centerX + roundOneWidth * 0.5)
end

LUI.createMenu.RoundStatus = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("RoundStatus", f1_arg0)
	if CoD.Zombie.IsDLCMap(CoD.Zombie.DLC2Maps) or CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps) or CoD.Zombie.IsDLCMap(CoD.Zombie.DLC4Maps) then
		CoD.RoundStatus.DefaultColor = {
			r = 0.41,
			g = 0,
			b = 0
		}
		CoD.RoundStatus.AlternatePulseColor = {
			r = 1,
			g = 1,
			b = 1
		}
		CoD.RoundStatus.Chalks[1] = RegisterMaterial("t5_chalkmarks_1")
		CoD.RoundStatus.Chalks[2] = RegisterMaterial("t5_chalkmarks_2")
		CoD.RoundStatus.Chalks[3] = RegisterMaterial("t5_chalkmarks_3")
		CoD.RoundStatus.Chalks[4] = RegisterMaterial("t5_chalkmarks_4")
		CoD.RoundStatus.Chalks[5] = RegisterMaterial("t5_chalkmarks_5")
	else
		CoD.RoundStatus.DefaultColor = {
			r = 0.41,
			g = 0,
			b = 0
		}
		CoD.RoundStatus.AlternatePulseColor = {
			r = 1,
			g = 1,
			b = 1
		}
		CoD.RoundStatus.Chalks[1] = RegisterMaterial("t5_chalkmarks_1")
		CoD.RoundStatus.Chalks[2] = RegisterMaterial("t5_chalkmarks_2")
		CoD.RoundStatus.Chalks[3] = RegisterMaterial("t5_chalkmarks_3")
		CoD.RoundStatus.Chalks[4] = RegisterMaterial("t5_chalkmarks_4")
		CoD.RoundStatus.Chalks[5] = RegisterMaterial("t5_chalkmarks_5")
	end
	f1_local0.gameTypeGroup = UIExpression.DvarString(nil, "ui_zm_gamemodegroup")
	f1_local0.gameType = UIExpression.DvarString(nil, "ui_gametype")
	f1_local0.startRound = Engine.GetGametypeSetting("startRound")
	if f1_local0.gameTypeGroup ~= CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER then
		CoD.RoundStatus.LeftOffset = CoD.RoundStatus.FactionIconLeftOffset
	else
		CoD.RoundStatus.LeftOffset = CoD.RoundStatus.RoundIconLeftOffset
	end
	f1_local0.scaleContainer = CoD.SplitscreenScaler.new(nil, CoD.Zombie.SplitscreenMultiplier)
	f1_local0.scaleContainer:setLeftRight(true, false, 0, 0)
	f1_local0.scaleContainer:setTopBottom(false, true, 0, 0)
	f1_local0:addElement(f1_local0.scaleContainer)
	local f1_local1, f1_local2, f1_local3, f1_local4 = Engine.GetUserSafeAreaForController(f1_arg0)
	f1_local0.safeAreaWidth = (f1_local3 - f1_local1) / f1_local0.scaleContainer.scale
	f1_local0.safeAreaHeight = (f1_local4 - f1_local2) / f1_local0.scaleContainer.scale
	f1_local0.chalkCenterTop = -f1_local0.safeAreaHeight * 0.5 - CoD.RoundStatus.ChalkSize * 1.5
	f1_local0.roundContainer = LUI.UIElement.new()
	f1_local0.roundContainer:setLeftRight(true, false, 0, 0)
	f1_local0.roundContainer:setTopBottom(false, true, 0, 0)
	f1_local0.scaleContainer:addElement(f1_local0.roundContainer)
	f1_local0.roundIconContainer = LUI.UIElement.new()
	f1_local0.roundIconContainer:setLeftRight(true, false, 0, 0)
	f1_local0.roundIconContainer:setTopBottom(false, true, 0, 0)
	f1_local0.scaleContainer:addElement(f1_local0.roundIconContainer)
	local f1_local5 = GetT5RoundCenterX(f1_local0)
	f1_local0.roundTextCenter = LUI.UIText.new()
	f1_local0.roundTextCenter:setLeftRight(true, false, f1_local5 + CoD.RoundStatus.ChalkSize * -0.5, f1_local5 + CoD.RoundStatus.ChalkSize * 0.5)
	f1_local0.roundTextCenter:setTopBottom(false, true, f1_local0.chalkCenterTop, f1_local0.chalkCenterTop + CoD.RoundStatus.RoundCenterHeight)
	f1_local0.roundTextCenter:setFont(CoD.fonts[CoD.RoundStatus.ChalkFontName])
	f1_local0.roundTextCenter:setAlignment(LUI.Alignment.Center)
	f1_local0.roundTextCenter:setAlpha(0)
	f1_local0.roundTextCenter:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
	f1_local0.roundTextCenter:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundTextCenterIdleFinish)
	f1_local0.roundContainer:addElement(f1_local0.roundTextCenter)
	f1_local0.roundText = LUI.UIText.new()
	f1_local0.roundText:setLeftRight(true, false, -8, 87)
	f1_local0.roundText:setTopBottom(false, true, -101, -6)
	f1_local0.roundText:setFont(CoD.fonts[CoD.RoundStatus.ChalkFontName])
	f1_local0.roundText:setAlpha(0)
	f1_local0.roundText:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
	f1_local0.roundText:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundTextIdleFinish)
	f1_local0.roundText:registerEventHandler("transition_complete_round_switch_show", CoD.RoundStatus.RoundSwitchShowFinish)
	f1_local0.roundText:registerEventHandler("transition_complete_round_switch_hide", CoD.RoundStatus.RoundSwitchHideFinish)
	f1_local0.roundContainer:addElement(f1_local0.roundText)
	f1_local0.roundChalk1 = LUI.UIImage.new()
	SetT5Chalk1Bounds(f1_local0.roundChalk1)
	f1_local0.roundChalk1:setImage(CoD.RoundStatus.Chalks[1])
	f1_local0.roundChalk1:setAlpha(0)
	f1_local0.roundChalk1:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
	f1_local0.roundChalk1:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundChalk1IdleFinish)
	f1_local0.roundChalk1:registerEventHandler("transition_complete_round_switch_show", CoD.RoundStatus.RoundSwitchShowFinish)
	f1_local0.roundChalk1:registerEventHandler("transition_complete_round_switch_hide", CoD.RoundStatus.RoundSwitchHideFinish)
	f1_local0.roundContainer:addElement(f1_local0.roundChalk1)
	f1_local0.roundChalk2 = LUI.UIImage.new()
	SetT5Chalk2Bounds(f1_local0.roundChalk2)
	f1_local0.roundChalk2:setImage(CoD.RoundStatus.Chalks[1])
	f1_local0.roundChalk2:setAlpha(0)
	f1_local0.roundChalk2:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
	f1_local0.roundChalk2:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundChalk2IdleFinish)
	f1_local0.roundChalk2:registerEventHandler("transition_complete_round_switch_show", CoD.RoundStatus.RoundSwitchShowFinish)
	f1_local0.roundChalk2:registerEventHandler("transition_complete_round_switch_hide", CoD.RoundStatus.RoundSwitchHideFinish)
	f1_local0.roundContainer:addElement(f1_local0.roundChalk2)
	f1_local0.factionIcon = LUI.UIImage.new()
	f1_local0.factionIcon:setLeftRight(true, false, CoD.RoundStatus.FactionIconLeftOffset, CoD.RoundStatus.FactionIconLeftOffset + CoD.RoundStatus.FactionIconSize)
	f1_local0.factionIcon:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.FactionIconSize)
	f1_local0.factionIcon:setAlpha(0)
	f1_local0.scaleContainer:addElement(f1_local0.factionIcon)
	f1_local0:registerEventHandler("hud_update_refresh", CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_PLAYER_IN_AFTERLIFE, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.RoundStatus.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_rounds_played", CoD.RoundStatus.UpdateRoundsPlayed)
	f1_local0:registerEventHandler("hud_update_team_change", CoD.RoundStatus.UpdateTeamChange)
	f1_local0:registerEventHandler("sq_tpo_special_round_active", CoD.RoundStatus.UpdateSpecialRound)
	f1_local0.timebombOverride = false
	if CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps) then
		f1_local0:registerEventHandler("time_bomb_lua_override", CoD.RoundStatus.TimeBombRoundAnimationOverride)
	end
	f1_local0.visible = true
	return f1_local0
end

CoD.RoundStatus.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_PLAYER_IN_AFTERLIFE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and (not CoD.IsShoutcaster(f2_local0) or CoD.ExeProfileVarBool(f2_local0, "shoutcaster_teamscore")) and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_SCOPED) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_FLASH_BANGED) == 0 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
end

CoD.RoundStatus.UpdateRoundsPlayed = function (f3_arg0, f3_arg1)
	if f3_arg0.gameType == CoD.Zombie.GAMETYPE_ZCLASSIC or f3_arg0.gameType == CoD.Zombie.GAMETYPE_ZSTANDARD or f3_arg0.gameType == CoD.Zombie.GAMETYPE_ZGRIEF then
		CoD.RoundStatus.RoundPulseTimes = math.ceil(CoD.RoundStatus.RoundPulseTimesMin + (1 - math.min(f3_arg1.roundsPlayed, CoD.RoundStatus.RoundMax) / CoD.RoundStatus.RoundMax) * CoD.RoundStatus.RoundPulseTimesDelta)
		if f3_arg0.startRound == f3_arg1.roundsPlayed then
			if f3_arg1.wasDemoJump == false and f3_arg0.timebombOverride == false and CoD.Zombie.AllowRoundAnimation == 1 then
				CoD.RoundStatus.ShowFirstRound(f3_arg0, f3_arg1.roundsPlayed)
			else
				SetT5Chalk1Bounds(f3_arg0.roundChalk1)
				local f3_local0 = CoD.RoundStatus.StartNewRound
				local f3_local1 = f3_arg0
				local f3_local2 = f3_arg1.roundsPlayed
				local f3_local3 = f3_arg1.wasDemoJump
				if not f3_local3 then
					f3_local3 = f3_arg0.timebombOverride == true
				end
				f3_local0(f3_local1, f3_local2, f3_local3)
			end
		elseif f3_arg0.startRound < f3_arg1.roundsPlayed then
			f3_arg0.roundChalk1:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
			f3_arg0.roundChalk1:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
			SetT5Chalk2Bounds(f3_arg0.roundChalk2)
			f3_arg0.roundText:setLeftRight(true, false, -8, 87)
			f3_arg0.roundText:setTopBottom(false, true, -101, -6)
			local f3_local0 = CoD.RoundStatus.StartNewRound
			local f3_local1 = f3_arg0
			local f3_local2 = f3_arg1.roundsPlayed
			local f3_local3 = f3_arg1.wasDemoJump
			if not f3_local3 then
				f3_local3 = f3_arg0.timebombOverride == true
			end
			f3_local0(f3_local1, f3_local2, f3_local3)
		else
			CoD.RoundStatus.HideAllRoundIcons(f3_arg0, f3_arg1)
		end
	else
		CoD.RoundStatus.HideAllRoundIcons(f3_arg0, f3_arg1)
	end
end

CoD.RoundStatus.ShowFirstRound = function (f4_arg0, f4_arg1)
	local f4_local0 = Engine.Localize("ZOMBIE_ROUND")
	local f4_local2 = GetTextWidthSafe(f4_local0, CoD.fonts[CoD.RoundStatus.ChalkFontName], CoD.RoundStatus.ChalkSize)
	local f4_local3 = GetT5RoundCenterX(f4_arg0)
	local f4_local4 = f4_arg0.chalkCenterTop
	f4_arg0.roundTextCenter:setLeftRight(true, false, f4_local3 + CoD.RoundStatus.ChalkSize * -0.5 - f4_local2, f4_local3 + CoD.RoundStatus.ChalkSize * 0.5 + f4_local2)
	f4_arg0.roundTextCenter:setText(f4_local0)
	f4_arg0.roundTextCenter:setAlpha(1)
	f4_arg0.roundTextCenter:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
	f4_arg0.roundTextCenter:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
	if f4_arg1 <= 5 then
		if f4_arg1 == 1 then
			SetT5RoundOneCenterBounds(f4_arg0, f4_arg0.roundChalk1)
		else
			f4_arg0.roundChalk1:setLeftRight(true, false, f4_local3 + CoD.RoundStatus.ChalkSize * -0.5, f4_local3 + CoD.RoundStatus.ChalkSize * 0.5)
		end
		f4_arg0.roundChalk1:setTopBottom(false, true, f4_local4 + CoD.RoundStatus.ChalkSize, f4_local4 + CoD.RoundStatus.ChalkSize * 2)
		f4_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[f4_arg1])
		f4_arg0.roundChalk1:setAlpha(1)
		f4_arg0.roundChalk1:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		f4_arg0.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f4_arg0.roundChalk2:completeAnimation()
		f4_arg0.roundChalk2:setAlpha(0)
		f4_arg0.roundText:completeAnimation()
		f4_arg0.roundText:setAlpha(0)
	elseif f4_arg1 <= 10 then
		f4_arg0.roundChalk1:setLeftRight(true, false, f4_local3 - CoD.RoundStatus.ChalkSize, f4_local3)
		f4_arg0.roundChalk1:setTopBottom(false, true, f4_local4 + CoD.RoundStatus.ChalkSize, f4_local4 + CoD.RoundStatus.ChalkSize * 2)
		f4_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		f4_arg0.roundChalk1:setAlpha(1)
		f4_arg0.roundChalk1:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		f4_arg0.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f4_arg0.roundChalk2:setLeftRight(true, false, f4_local3, f4_local3 + CoD.RoundStatus.ChalkSize)
		f4_arg0.roundChalk2:setTopBottom(false, true, f4_local4 + CoD.RoundStatus.ChalkSize, f4_local4 + CoD.RoundStatus.ChalkSize * 2)
		f4_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[f4_arg1 - 5])
		f4_arg0.roundChalk2:setAlpha(1)
		f4_arg0.roundChalk2:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		f4_arg0.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
	else
		local f4_local6 = GetTextWidthSafe(f4_arg1, CoD.fonts[CoD.RoundStatus.ChalkFontName], CoD.RoundStatus.ChalkSize)
		f4_arg0.roundText:setLeftRight(true, false, f4_local3 + CoD.RoundStatus.ChalkSize * -0.5 - f4_local6, f4_local3 + CoD.RoundStatus.ChalkSize * 0.5 + f4_local6)
		f4_arg0.roundText:setTopBottom(false, true, f4_local4 + CoD.RoundStatus.ChalkSize, f4_local4 + CoD.RoundStatus.ChalkSize * 2)
		f4_arg0.roundText:setText(f4_arg1)
		f4_arg0.roundText:setAlignment(LUI.Alignment.Center)
		f4_arg0.roundText:setAlpha(1)
		f4_arg0.roundText:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		f4_arg0.roundText:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
	end
end

CoD.RoundStatus.ShowFirstRoundFinish = function (f5_arg0, f5_arg1)
	if f5_arg1.interrupted ~= true then
		f5_arg0:beginAnimation("idle", CoD.RoundStatus.FirstRoundIdleDuration)
	end
end

CoD.RoundStatus.ShowFirstRoundTextCenterIdleFinish = function (f6_arg0, f6_arg1)
	if f6_arg1.interrupted ~= true then
		f6_arg0:beginAnimation("fade_out", CoD.RoundStatus.FirstRoundDuration)
		f6_arg0:setAlpha(0)
	end
end

CoD.RoundStatus.ShowFirstRoundTextIdleFinish = function (f7_arg0, f7_arg1)
	if f7_arg1.interrupted ~= true then
		f7_arg0:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
		f7_arg0:setLeftRight(true, false, -8, 87)
		f7_arg0:setTopBottom(false, true, -101, -6)
	end
end

CoD.RoundStatus.ShowFirstRoundChalk1IdleFinish = function (f8_arg0, f8_arg1)
	if f8_arg1.interrupted ~= true then
		f8_arg0:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
		SetT5Chalk1Bounds(f8_arg0)
	end
end

CoD.RoundStatus.ShowFirstRoundChalk2IdleFinish = function (f9_arg0, f9_arg1)
	if f9_arg1.interrupted ~= true then
		f9_arg0:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
		SetT5Chalk2Bounds(f9_arg0)
	end
end

CoD.RoundStatus.StartNewRound = function (f10_arg0, f10_arg1, f10_arg2)
	if f10_arg1 <= 5 then
		f10_arg0.roundChalk1:setAlpha(1)
		if f10_arg2 == true then
			f10_arg0.roundChalk1:completeAnimation()
			f10_arg0.roundChalk1:setAlpha(1)
			f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
			f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[f10_arg1])
		else
			if f10_arg1 > 1 then
				f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[f10_arg1 - 1])
			end
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[f10_arg1]
			f10_arg0.roundChalk1.showInLastPulse = true
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
		end
		f10_arg0.roundChalk2:completeAnimation()
		f10_arg0.roundChalk2:setAlpha(0)
		f10_arg0.roundText:completeAnimation()
		f10_arg0.roundText:setAlpha(0)
	elseif f10_arg1 == 6 then
		f10_arg0.roundChalk1:setAlpha(1)
		f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		if f10_arg2 == true then
			f10_arg0.roundChalk2:setAlpha(1)
			f10_arg0.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
			f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[1])
		else
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk1.showInLastPulse = true
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
			f10_arg0.roundChalk2.pulseTimes = 0
			f10_arg0.roundChalk2.material = CoD.RoundStatus.Chalks[f10_arg1 - 5]
			f10_arg0.roundChalk2.showInLastPulse = true
			f10_arg0.roundChalk2.showInPreviousPulses = false
			f10_arg0.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundChalk2:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
		end
		f10_arg0.roundText:completeAnimation()
		f10_arg0.roundText:setAlpha(0)
	elseif f10_arg1 <= 10 then
		f10_arg0.roundChalk1:setAlpha(1)
		f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		f10_arg0.roundChalk2:setAlpha(1)
		f10_arg0.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[f10_arg1 - 5 - 1])
		if f10_arg2 == true then
			f10_arg0.roundChalk1:setAlpha(1)
			f10_arg0.roundChalk2:setAlpha(1)
			f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[f10_arg1 - 5])
		else
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk1.showInLastPulse = true
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
			f10_arg0.roundChalk2.pulseTimes = 0
			f10_arg0.roundChalk2.material = CoD.RoundStatus.Chalks[f10_arg1 - 5]
			f10_arg0.roundChalk2.showInLastPulse = true
			f10_arg0.roundChalk2.showInPreviousPulses = true
			f10_arg0.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundChalk2:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
		end
		f10_arg0.roundText:completeAnimation()
		f10_arg0.roundText:setAlpha(0)
	elseif f10_arg1 == 11 then
		f10_arg0.roundChalk1:setAlpha(1)
		f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		f10_arg0.roundChalk2:setAlpha(1)
		f10_arg0.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[5])
		if f10_arg2 == true then
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundText:setAlpha(1)
			f10_arg0.roundText:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
			f10_arg0.roundText:setText(f10_arg1)
		else
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk1.showInLastPulse = false
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
			f10_arg0.roundChalk2.pulseTimes = 0
			f10_arg0.roundChalk2.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk2.showInLastPulse = false
			f10_arg0.roundChalk2.showInPreviousPulses = true
			f10_arg0.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundChalk2:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
			f10_arg0.roundText.pulseTimes = 0
			f10_arg0.roundText.material = f10_arg1
			f10_arg0.roundText.showInLastPulse = true
			f10_arg0.roundText.showInPreviousPulses = false
			f10_arg0.roundText:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundText:setAlpha(0)
			f10_arg0.roundText:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
		end
	else
		f10_arg0.roundText:setAlpha(1)
		f10_arg0.roundText:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
		f10_arg0.roundText:setText(f10_arg1 - 1)
		if f10_arg2 == true then
			f10_arg0.roundText:setText(f10_arg1)
		else
			f10_arg0.roundText.pulseTimes = 0
			f10_arg0.roundText.material = f10_arg1
			f10_arg0.roundText.showInLastPulse = true
			f10_arg0.roundText.showInPreviousPulses = true
			f10_arg0.roundText:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundText:setAlpha(0)
			f10_arg0.roundText:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
		end
		f10_arg0.roundChalk1:completeAnimation()
		f10_arg0.roundChalk1:setAlpha(0)
		f10_arg0.roundChalk2:completeAnimation()
		f10_arg0.roundChalk2:setAlpha(0)
	end
end

CoD.RoundStatus.RoundSwitchShowFinish = function (f11_arg0, f11_arg1)
	if f11_arg1.interrupted ~= true then
		f11_arg0.pulseTimes = f11_arg0.pulseTimes + 1
		if f11_arg0.pulseTimes <= CoD.RoundStatus.RoundPulseTimes then
			if f11_arg0.pulseTimes > CoD.RoundStatus.RoundPulseTimes - 1 then
				f11_arg0:beginAnimation("round_switch_hide", CoD.RoundStatus.FirstRoundDuration)
				f11_arg0:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
			else
				f11_arg0:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			end
			f11_arg0:setAlpha(0)
		end
	end
end

CoD.RoundStatus.RoundSwitchHideFinish = function (f12_arg0, f12_arg1)
	if f12_arg1.interrupted ~= true then
		local f12_local0 = 1
		if f12_arg0.pulseTimes > CoD.RoundStatus.RoundPulseTimes - 1 then
			if type(f12_arg0.material) == "number" then
				f12_arg0:setText(f12_arg0.material)
			else
				f12_arg0:setImage(f12_arg0.material)
			end
			if f12_arg0.showInLastPulse == false then
				f12_local0 = 0
			end
			f12_arg0:beginAnimation("round_switch_show", CoD.RoundStatus.FirstRoundDuration)
		else
			if f12_arg0.showInPreviousPulses == false then
				f12_local0 = 0
			end
			f12_arg0:beginAnimation("round_switch_show", CoD.RoundStatus.RoundPulseDuration)
		end
		f12_arg0:setAlpha(f12_local0)
	end
end

CoD.RoundStatus.UpdateTeamChange = function (f13_arg0, f13_arg1)
	if f13_arg0.team ~= f13_arg1.team and type(f13_arg1.team) == "number" and f13_arg1.team < CoD.TEAM_SPECTATOR then
		f13_arg0.team = f13_arg1.team
		if f13_arg0.team ~= CoD.TEAM_FREE then
			local f13_local0 = Engine.GetFactionForTeam(f13_arg1.team)
			if f13_local0 ~= "" and f13_arg0.gameTypeGroup == CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER then
				if CoD.Zombie.GAMETYPE_ZCLEANSED == Dvar.ui_gametype:get() and f13_arg0.team == CoD.TEAM_AXIS then
					f13_local0 = "zombie"
				elseif CoD.Zombie.GAMETYPE_ZMEAT == Dvar.ui_gametype:get() and f13_arg0.team == CoD.TEAM_AXIS then
					f13_local0 = "cia"
				end
				f13_arg0.factionIcon:setImage(RegisterMaterial("faction_" .. f13_local0))
				f13_arg0.factionIcon:setAlpha(1)
			else
				f13_arg0.factionIcon:setAlpha(0)
			end
		else
			f13_arg0.factionIcon:setAlpha(0)
		end
	end
end

CoD.RoundStatus.HideAllRoundIcons = function (f14_arg0, f14_arg1)
	f14_arg0.roundTextCenter:setAlpha(0)
	f14_arg0.roundText:setAlpha(0)
	f14_arg0.roundChalk1:setAlpha(0)
	f14_arg0.roundChalk2:setAlpha(0)
end

CoD.RoundStatus.UpdateSpecialRound = function (f15_arg0, f15_arg1)
	if f15_arg1.newValue == 1 then
		if not f15_arg0.specialRoundIcon then
			f15_arg0.specialRoundIcon = LUI.UIImage.new()
			f15_arg0.specialRoundIcon:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.SpecialRoundIconSize)
			f15_arg0.specialRoundIcon:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.SpecialRoundIconSize / 2)
			f15_arg0.specialRoundIcon:setImage(RegisterMaterial("hud_zm_chalk_infinity"))
			f15_arg0.specialRoundIcon:setAlpha(0)
			f15_arg0.roundIconContainer:addElement(f15_arg0.specialRoundIcon)
		end
		f15_arg0.specialRoundIcon:beginAnimation("fade_in", 1000)
		f15_arg0.specialRoundIcon:setAlpha(1)
		f15_arg0.roundContainer:beginAnimation("fade_out", 500)
		f15_arg0.roundContainer:setAlpha(0)
	else
		f15_arg0.specialRoundIcon:beginAnimation("fade_out", 500)
		f15_arg0.specialRoundIcon:setAlpha(0)
		f15_arg0.roundContainer:beginAnimation("fade_in", 1000)
		f15_arg0.roundContainer:setAlpha(1)
	end
end

CoD.RoundStatus.TimeBombRoundAnimationOverride = function (f16_arg0, f16_arg1)
	if f16_arg1.newValue == 1 then
		f16_arg0.timebombOverride = true
	else
		f16_arg0.timebombOverride = false
	end
end

