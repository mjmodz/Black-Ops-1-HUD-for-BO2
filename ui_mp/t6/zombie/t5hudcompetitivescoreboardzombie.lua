
CoD.CompetitiveScoreboard = {}
CoD.CompetitiveScoreboard.RowWidth = 150
CoD.CompetitiveScoreboard.RowHeight = 30
CoD.CompetitiveScoreboard.FloatingLosePointsColor = {
	r = 0.21,
	g = 0,
	b = 0
}
CoD.CompetitiveScoreboard.IsDLC2Map = CoD.Zombie.IsDLCMap(CoD.Zombie.DLC2Maps)
CoD.CompetitiveScoreboard.IsDLC3Map = CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps)
CoD.CompetitiveScoreboard.IsDLC4Map = CoD.Zombie.IsDLCMap(CoD.Zombie.DLC4Maps)
CoD.CompetitiveScoreboard.LeftOffset = 0
if CoD.CompetitiveScoreboard.IsDLC2Map == true then
	CoD.CompetitiveScoreboard.Bottom = -145
elseif CoD.CompetitiveScoreboard.IsDLC3Map == true then
	CoD.CompetitiveScoreboard.Bottom = -145
	CoD.CompetitiveScoreboard.FloatingLosePointsColor = CoD.red
elseif CoD.CompetitiveScoreboard.IsDLC4Map == true then
	CoD.CompetitiveScoreboard.Bottom = -105
	CoD.CompetitiveScoreboard.LeftOffset = CoD.CompetitiveScoreboard.RowHeight
else
	CoD.CompetitiveScoreboard.Bottom = -90
end
CoD.CompetitiveScoreboard.TeamPlayerCount = 8
CoD.CompetitiveScoreboard.CHARACTER_NAME_ONSCREEN_DURATION = 15000
CoD.CompetitiveScoreboard.CHARACTER_NAME_FADE_OUT_DURATION = 1000
CoD.CompetitiveScoreboard.ClientFieldMaxValue = 20
CoD.CompetitiveScoreboard.ClientFieldCount = 7
CoD.CompetitiveScoreboard.ClientFields = {}
CoD.CompetitiveScoreboard.ClientFields.score_cf_damage = {
	min = 0,
	max = 7,
	scoreScale = 10
}
CoD.CompetitiveScoreboard.ClientFields.score_cf_death_normal = {
	min = 0,
	max = 3,
	scoreScale = 50
}
CoD.CompetitiveScoreboard.ClientFields.score_cf_death_torso = {
	min = 0,
	max = 3,
	scoreScale = 60
}
CoD.CompetitiveScoreboard.ClientFields.score_cf_death_neck = {
	min = 0,
	max = 3,
	scoreScale = 70
}
CoD.CompetitiveScoreboard.ClientFields.score_cf_death_head = {
	min = 0,
	max = 3,
	scoreScale = 100
}
CoD.CompetitiveScoreboard.ClientFields.score_cf_death_melee = {
	min = 0,
	max = 3,
	scoreScale = 130
}
CoD.CompetitiveScoreboard.ClientFields.score_cf_double_points_active = {
	min = 0,
	max = 1,
	scoreScale = 2
}
CoD.CompetitiveScoreboard.DoublePointsActive_ClientFieldName = "score_cf_double_points_active"
CoD.CompetitiveScoreboard.FlyingDurationMin = 800
CoD.CompetitiveScoreboard.FlyingDurationMax = 1000
CoD.CompetitiveScoreboard.FlyingLeftOffSetMin = 100
CoD.CompetitiveScoreboard.FlyingLeftOffSetMax = 120
CoD.CompetitiveScoreboard.FlyingTopOffSetMin = 0
CoD.CompetitiveScoreboard.FlyingTopOffSetMax = 100
CoD.CompetitiveScoreboard.NavCard_ClientFieldName = "navcard_held"
CoD.CompetitiveScoreboard.NavCardsCount = 3
CoD.CompetitiveScoreboard.NavCards = {}
CoD.CompetitiveScoreboard.NavCards[1] = RegisterMaterial("zm_hud_icon_sq_keycard")
CoD.CompetitiveScoreboard.NavCards[2] = RegisterMaterial("zm_hud_icon_sq_keycard_2")
CoD.CompetitiveScoreboard.NavCards[3] = RegisterMaterial("zm_hud_icon_sq_keycard_buried")
CoD.CompetitiveScoreboard.NEED_SHOVEL = 0
CoD.CompetitiveScoreboard.HAVE_SHOVEL = 1
CoD.CompetitiveScoreboard.HAVE_UG_SHOVEL = 2
CoD.CompetitiveScoreboard.NEED_HELMET = 0
CoD.CompetitiveScoreboard.HAVE_HELMET = 1
if CoD.CompetitiveScoreboard.IsDLC2Map == true then
	CoD.CompetitiveScoreboard.CharacterNames = {}
	CoD.CompetitiveScoreboard.CharacterNames[1] = {
		name = "Finn",
		modelName = "c_zom_player_oleary_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[2] = {
		name = "Sal",
		modelName = "c_zom_player_deluca_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[3] = {
		name = "Billy",
		modelName = "c_zom_player_handsome_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[4] = {
		name = "Weasel",
		modelName = "c_zom_player_arlington_fb"
	}
elseif CoD.CompetitiveScoreboard.IsDLC3Map == true then
	CoD.CompetitiveScoreboard.CharacterNames = {}
	CoD.CompetitiveScoreboard.CharacterNames[1] = {
		name = "Misty",
		modelName = "c_zom_player_farmgirl_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[2] = {
		name = "Marlton",
		modelName = "c_zom_player_engineer_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[3] = {
		name = "Stuhlinger",
		modelName = "c_zom_player_reporter_dam_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[4] = {
		name = "Russman",
		modelName = "c_zom_player_oldman_fb"
	}
elseif CoD.CompetitiveScoreboard.IsDLC4Map == true then
	CoD.CompetitiveScoreboard.CharacterNames = {}
	CoD.CompetitiveScoreboard.CharacterNames[1] = {
		name = "Richtofen",
		modelName = "c_zom_tomb_richtofen_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[2] = {
		name = "Takeo",
		modelName = "c_zom_tomb_takeo_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[3] = {
		name = "Nikolai",
		modelName = "c_zom_tomb_nikolai_fb"
	}
	CoD.CompetitiveScoreboard.CharacterNames[4] = {
		name = "Dempsey",
		modelName = "c_zom_tomb_dempsey_fb"
	}
end

LUI.createMenu.CompetitiveScoreboard = function (LocalClientIndex)
	local CompetitiveScoreboardWidget = CoD.Menu.NewSafeAreaFromState("CompetitiveScoreboard", LocalClientIndex)
	CompetitiveScoreboardWidget:setOwner(LocalClientIndex)
	CompetitiveScoreboardWidget.scaleContainer = CoD.SplitscreenScaler.new(nil, CoD.Zombie.SplitscreenMultiplier)
	CompetitiveScoreboardWidget.scaleContainer:setLeftRight(true, true, 0, 0)
	CompetitiveScoreboardWidget.scaleContainer:setTopBottom(true, true, 0, 0)
	CompetitiveScoreboardWidget:addElement(CompetitiveScoreboardWidget.scaleContainer)
	if CoD.CompetitiveScoreboard.BackGroundMaterial == nil then
		CoD.CompetitiveScoreboard.BackGroundMaterial = RegisterMaterial("scorebar_zom_1")
	end
	local CharacterNameFont = "Default"
	local CharacterNameTextSize = CoD.textSize[CharacterNameFont]
	CompetitiveScoreboardWidget.Scores = {}
	for ClientIndex = 1, CoD.CompetitiveScoreboard.TeamPlayerCount, 1 do
		local VerticalOffset = CoD.CompetitiveScoreboard.Bottom - CoD.CompetitiveScoreboard.RowHeight * ClientIndex
		local PlayerScoreListWidget = LUI.UIElement.new()
		PlayerScoreListWidget:setLeftRight(false, true, -CoD.CompetitiveScoreboard.RowWidth, 0)
		PlayerScoreListWidget:setTopBottom(false, true, VerticalOffset - CoD.CompetitiveScoreboard.RowHeight, VerticalOffset)
		PlayerScoreListWidget:setAlpha(0)
		PlayerScoreListWidget.scoreBg = LUI.UIImage.new()
		PlayerScoreListWidget.scoreBg:setLeftRight(true, true, 0, 0)
		PlayerScoreListWidget.scoreBg:setTopBottom(true, true, 0, 0)
		PlayerScoreListWidget.scoreBg:setRGB(0.21, 0, 0)
		PlayerScoreListWidget.scoreBg:setImage(CoD.CompetitiveScoreboard.BackGroundMaterial)
		PlayerScoreListWidget:addElement(PlayerScoreListWidget.scoreBg)
		if CoD.Zombie.IsCharacterNameDisplayMap() == true then
			PlayerScoreListWidget.characterName = LUI.UIText.new()
			PlayerScoreListWidget.characterName:setLeftRight(false, true, -CoD.CompetitiveScoreboard.RowWidth * 2, -CoD.CompetitiveScoreboard.RowWidth - 10)
			PlayerScoreListWidget.characterName:setTopBottom(false, false, -CharacterNameTextSize / 2, CharacterNameTextSize / 2)
			PlayerScoreListWidget.characterName:setFont(CoD.fonts[CharacterNameFont])
			PlayerScoreListWidget.characterName:setAlignment(LUI.Alignment.Right)
			if CoD.CompetitiveScoreboard.IsDLC3Map == true then
				PlayerScoreListWidget.characterName:registerEventHandler("character_name_fade_out", CoD.CompetitiveScoreboard.FadeoutCharacterName)
			end
			PlayerScoreListWidget:addElement(PlayerScoreListWidget.characterName)
		end
		PlayerScoreListWidget.scoreText = LUI.UIText.new()
		PlayerScoreListWidget.scoreText:setLeftRight(true, false, 10, CoD.CompetitiveScoreboard.RowWidth)
		PlayerScoreListWidget.scoreText:setTopBottom(true, true, 0, 0)
		PlayerScoreListWidget:addElement(PlayerScoreListWidget.scoreText)
		PlayerScoreListWidget.floatingScoreTexts = {}
		for ClientFieldIndex = 1, CoD.CompetitiveScoreboard.ClientFieldMaxValue, 1 do
			local FloatingScoreText = LUI.UIText.new()
			FloatingScoreText:setPriority(20)
			FloatingScoreText:setLeftRight(true, false, 10, 10 + CoD.CompetitiveScoreboard.RowWidth)
			FloatingScoreText:setTopBottom(true, false, 0, CoD.CompetitiveScoreboard.RowHeight)
			FloatingScoreText:setAlpha(0)
			FloatingScoreText.isUsed = false
			FloatingScoreText:registerEventHandler("transition_complete_flying_out", CoD.CompetitiveScoreboard.FloatingTextFlyingFinish)
			PlayerScoreListWidget:addElement(FloatingScoreText)
			PlayerScoreListWidget.floatingScoreTexts[ClientFieldIndex] = FloatingScoreText
		end
		if CoD.CompetitiveScoreboard.IsDLC4Map == true then
			CoD.CompetitiveScoreboard.ShovelStates = {
				0,
				0,
				0,
				0
			}
			CoD.CompetitiveScoreboard.HelmetStates = {
				0,
				0,
				0,
				0
			}
			PlayerScoreListWidget.shovelIcon = LUI.UIImage.new()
			PlayerScoreListWidget.shovelIcon:setLeftRight(false, true, -CoD.CompetitiveScoreboard.RowHeight, 0)
			PlayerScoreListWidget.shovelIcon:setTopBottom(false, false, -CoD.CompetitiveScoreboard.RowHeight * 0.5, CoD.CompetitiveScoreboard.RowHeight * 0.5)
			PlayerScoreListWidget.shovelIcon:setAlpha(0)
			PlayerScoreListWidget:addElement(PlayerScoreListWidget.shovelIcon)
			PlayerScoreListWidget.shovelIcon.itemState = CoD.CompetitiveScoreboard.NEED_SHOVEL
			PlayerScoreListWidget.helmetIcon = LUI.UIImage.new()
			PlayerScoreListWidget.helmetIcon:setLeftRight(false, true, 0, CoD.CompetitiveScoreboard.RowHeight)
			PlayerScoreListWidget.helmetIcon:setTopBottom(false, false, -CoD.CompetitiveScoreboard.RowHeight * 0.5, CoD.CompetitiveScoreboard.RowHeight * 0.5)
			PlayerScoreListWidget.helmetIcon:setAlpha(0)
			PlayerScoreListWidget:addElement(PlayerScoreListWidget.helmetIcon)
			PlayerScoreListWidget.helmetIcon.itemState = CoD.CompetitiveScoreboard.NEED_HELMET
		end
		PlayerScoreListWidget.navCardIcons = {}
		for NavCardsIndex = 1, CoD.CompetitiveScoreboard.NavCardsCount, 1 do
			local NavCardIcon = LUI.UIImage.new()
			NavCardIcon:setLeftRight(false, true, -CoD.CompetitiveScoreboard.RowHeight, 0)
			NavCardIcon:setTopBottom(false, false, -CoD.CompetitiveScoreboard.RowHeight * 0.5, CoD.CompetitiveScoreboard.RowHeight * 0.5)
			NavCardIcon:setAlpha(0)
			PlayerScoreListWidget:addElement(NavCardIcon)
			PlayerScoreListWidget.navCardIcons[NavCardsIndex] = NavCardIcon
		end
		PlayerScoreListWidget.preScore = 0
		PlayerScoreListWidget.currentScore = 0
		PlayerScoreListWidget.doublePointsActive = 1
		PlayerScoreListWidget.currentClientFieldScore = 0
		PlayerScoreListWidget.currentUsedFloatingScoreTextNum = 0
		CompetitiveScoreboardWidget.Scores[ClientIndex] = PlayerScoreListWidget
		CompetitiveScoreboardWidget.scaleContainer:addElement(PlayerScoreListWidget)
	end
	for ClientFieldIndex, ClientFieldValue in pairs(CoD.CompetitiveScoreboard.ClientFields) do
		CompetitiveScoreboardWidget:registerEventHandler(ClientFieldIndex, CoD.CompetitiveScoreboard.Update_ClientFields_FlyingScore)
	end
	if CoD.CompetitiveScoreboard.IsDLC4Map == true then
		CoD.CompetitiveScoreboard.ShovelMaterial = RegisterMaterial("zom_hud_craftable_tank_shovel")
		CoD.CompetitiveScoreboard.ShovelGoldMaterial = RegisterMaterial("zom_hud_shovel_gold")
		CoD.CompetitiveScoreboard.HardHatMaterial = RegisterMaterial("zom_hud_helmet_gold")
		for ClientIndex = 1, 4, 1 do
			CompetitiveScoreboardWidget:registerEventHandler("shovel_player" .. ClientIndex, CoD.CompetitiveScoreboard.Update_ClientField_Shovel)
			CompetitiveScoreboardWidget:registerEventHandler("helmet_player" .. ClientIndex, CoD.CompetitiveScoreboard.Update_ClientField_Helmet)
		end
	elseif CoD.Zombie.IsSideQuestMap(Dvar.ui_mapname:get()) then
		CompetitiveScoreboardWidget:registerEventHandler(CoD.CompetitiveScoreboard.NavCard_ClientFieldName, CoD.CompetitiveScoreboard.Update_ClientField_NavCards)
	end
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_competitive_scoreboard", CoD.CompetitiveScoreboard.Update)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_refresh", CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_PLAYER_IN_AFTERLIFE, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_PLAYER_DEAD, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.CompetitiveScoreboard.UpdateVisibility)
	CompetitiveScoreboardWidget:registerEventHandler("hud_update_team_change", CoD.CompetitiveScoreboard.UpdateTeamChange)
	CompetitiveScoreboardWidget.visible = true
	return CompetitiveScoreboardWidget
end

CoD.CompetitiveScoreboard.CompetitiveScoreShow = function (PlayerScoreListWidget, LocalClientIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end
	local VerticalOffset = CoD.CompetitiveScoreboard.Bottom - CoD.CompetitiveScoreboard.RowHeight * LocalClientIndex
	PlayerScoreListWidget:beginAnimation("show", AnimDelay)
	PlayerScoreListWidget:setLeftRight(false, true, -CoD.CompetitiveScoreboard.RowWidth - CoD.CompetitiveScoreboard.LeftOffset, -CoD.CompetitiveScoreboard.LeftOffset)
	PlayerScoreListWidget:setTopBottom(false, true, VerticalOffset - CoD.CompetitiveScoreboard.RowHeight + 3, VerticalOffset - 3)
	PlayerScoreListWidget:setAlpha(1)
end

CoD.CompetitiveScoreboard.CompetitiveScoreShowSelf = function (PlayerScoreListWidget, ClientScoreIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end
	local VerticalOffset = CoD.CompetitiveScoreboard.Bottom - CoD.CompetitiveScoreboard.RowHeight * ClientScoreIndex
	PlayerScoreListWidget:beginAnimation("showself", AnimDelay)
	PlayerScoreListWidget:setLeftRight(false, true, -CoD.CompetitiveScoreboard.RowWidth - CoD.CompetitiveScoreboard.LeftOffset - 8, -CoD.CompetitiveScoreboard.LeftOffset)
	PlayerScoreListWidget:setTopBottom(false, true, VerticalOffset - CoD.CompetitiveScoreboard.RowHeight - 5, VerticalOffset + 5)
	PlayerScoreListWidget:setAlpha(1)
end

CoD.CompetitiveScoreboard.CompetitiveScoreHide = function (PlayerScoreListWidget, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end
	PlayerScoreListWidget:beginAnimation("hide", AnimDelay)
	PlayerScoreListWidget:setAlpha(0)
end

CoD.CompetitiveScoreboard.CompetitiveScoreTextShowPlayerColor = function (Text, LocalClientIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end
	local ZombiesColorIndex = (LocalClientIndex - 1) % 4 + 1
	Text:beginAnimation("showplayercolor", AnimDelay)
	Text:setRGB(CoD.Zombie.PlayerColors[ZombiesColorIndex].r, CoD.Zombie.PlayerColors[ZombiesColorIndex].g, CoD.Zombie.PlayerColors[ZombiesColorIndex].b)
end

CoD.CompetitiveScoreboard.UpdateVisibility = function (CompetitiveScoreboardWidget, ClientInstance)
	local LocalClientIndex = ClientInstance.controller
	if UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IS_PLAYER_IN_AFTERLIFE) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IS_SCOPED) == 0 and (not CoD.IsShoutcaster(LocalClientIndex) or CoD.IsShoutcasterProfileVariableTrue(LocalClientIndex, "shoutcaster_scorestreaks") and Engine.IsSpectatingActiveClient(LocalClientIndex)) and CoD.FSM_VISIBILITY(LocalClientIndex) == 0 then
		if CompetitiveScoreboardWidget.visible ~= true then
			CompetitiveScoreboardWidget:setAlpha(1)
			CompetitiveScoreboardWidget.m_inputDisabled = nil
			CompetitiveScoreboardWidget.visible = true
		end
	elseif CompetitiveScoreboardWidget.visible == true then
		CompetitiveScoreboardWidget:setAlpha(0)
		CompetitiveScoreboardWidget.m_inputDisabled = true
		CompetitiveScoreboardWidget.visible = nil
	end
	CompetitiveScoreboardWidget:dispatchEventToChildren(ClientInstance)
end

CoD.CompetitiveScoreboard.UpdateTeamChange = function (CompetitiveScoreboardWidget, ClientInstance)
	if Dvar.ui_gametype:get() == CoD.Zombie.GAMETYPE_ZCLEANSED then
		if ClientInstance.team == CoD.TEAM_AXIS then
			if CompetitiveScoreboardWidget.visible == true then
				CompetitiveScoreboardWidget:setAlpha(0)
				CompetitiveScoreboardWidget.m_inputDisabled = true
				CompetitiveScoreboardWidget.visible = false
			end
		elseif CompetitiveScoreboardWidget.visible ~= true then
			CompetitiveScoreboardWidget:setAlpha(1)
			CompetitiveScoreboardWidget.m_inputDisabled = nil
			CompetitiveScoreboardWidget.visible = true
		end
	end
end

CoD.CompetitiveScoreboard.CopyPreNavCardAndShow = function (CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClientIndex)
	local PreviousPlayerScoreListWidget = nil
	for PlayerScoreListWidgetIndex = 1, CoD.CompetitiveScoreboard.TeamPlayerCount, 1 do
		PreviousPlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[PlayerScoreListWidgetIndex]
			for NavCardIndex = 1, CoD.CompetitiveScoreboard.NavCardsCount, 1 do
				if PlayerScoreListWidget.navCardIcons[NavCardIndex].material ~= nil then
					PlayerScoreListWidget.navCardIcons[NavCardIndex].material = PreviousPlayerScoreListWidget.navCardIcons[NavCardIndex].material
					PlayerScoreListWidget.navCardIcons[NavCardIndex]:setImage(PreviousPlayerScoreListWidget.navCardIcons[NavCardIndex].material)
					PlayerScoreListWidget.navCardIcons[NavCardIndex]:setAlpha(1)
					print("showing navcards")
				else
					PlayerScoreListWidget.navCardIcons[NavCardIndex]:setAlpha(0)
				end
			end
	end
end

CoD.CompetitiveScoreboard.UpdateItemDisplay = function (UnusedArg1, PlayerScoreListWidget, ClientInstance)
	if PlayerScoreListWidget.clientNum then
		local ClientIndex = PlayerScoreListWidget.clientNum + 1
		local ShovelClientFieldState = CoD.CompetitiveScoreboard.ShovelStates[ClientIndex]
		local HelmetClientFieldState = CoD.CompetitiveScoreboard.HelmetStates[ClientIndex]
		if PlayerScoreListWidget.shovelIcon then
			if ShovelClientFieldState == CoD.CompetitiveScoreboard.HAVE_SHOVEL then
				PlayerScoreListWidget.shovelIcon:setImage(CoD.CompetitiveScoreboard.ShovelMaterial)
				PlayerScoreListWidget.shovelIcon:setAlpha(1)
				PlayerScoreListWidget.shovelIcon.material = CoD.CompetitiveScoreboard.ShovelMaterial
			elseif ShovelClientFieldState == CoD.CompetitiveScoreboard.HAVE_UG_SHOVEL then
				PlayerScoreListWidget.shovelIcon:setImage(CoD.CompetitiveScoreboard.ShovelGoldMaterial)
				PlayerScoreListWidget.shovelIcon:setAlpha(1)
				PlayerScoreListWidget.shovelIcon.material = CoD.CompetitiveScoreboard.ShovelGoldMaterial
			else
				PlayerScoreListWidget.shovelIcon:setAlpha(0)
				PlayerScoreListWidget.shovelIcon.material = nil
			end
		end
		if PlayerScoreListWidget.helmetIcon then
			if HelmetClientFieldState == CoD.CompetitiveScoreboard.HAVE_HELMET then
				PlayerScoreListWidget.helmetIcon:setImage(CoD.CompetitiveScoreboard.HardHatMaterial)
				PlayerScoreListWidget.helmetIcon:setAlpha(1)
				PlayerScoreListWidget.helmetIcon.material = CoD.CompetitiveScoreboard.HardHatMaterial
			else
				PlayerScoreListWidget.helmetIcon:setAlpha(0)
				PlayerScoreListWidget.helmetIcon.material = nil
			end
		end
	end
end

CoD.CompetitiveScoreboard.Update = function (CompetitiveScoreboardWidget, ClientInstance)
	local ClientScoreIndex = 1
	local PlayerScoreListWidget = nil
	if #ClientInstance.competitivescores <= #CompetitiveScoreboardWidget.Scores then
		for ClientIndex, LocalClient in pairs(ClientInstance.competitivescores) do
			ClientScoreIndex = #ClientInstance.competitivescores - ClientIndex + 1
			PlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[ClientScoreIndex]
			PlayerScoreListWidget.scoreText:setText(LocalClient.score)
			if CoD.Zombie.IsSideQuestMap(Dvar.ui_mapname:get()) then
				CoD.CompetitiveScoreboard.CopyPreNavCardAndShow(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient.clientNum)
			end
			local ClientNumsAreSame = PlayerScoreListWidget.clientNum ~= LocalClient.clientNum
			PlayerScoreListWidget.preScore = CompetitiveScoreboardWidget.Scores[ClientScoreIndex].currentScore
			PlayerScoreListWidget.currentScore = LocalClient.score
			PlayerScoreListWidget.clientNum = LocalClient.clientNum
			local ScoreAmount = PlayerScoreListWidget.currentScore - PlayerScoreListWidget.preScore - PlayerScoreListWidget.currentClientFieldScore
			if ScoreAmount ~= 0 and ClientInstance.bWasDemoJump == false and ClientNumsAreSame == false then
				CoD.CompetitiveScoreboard.FloatingScoreStart(PlayerScoreListWidget, ScoreAmount)
			end
			PlayerScoreListWidget.currentClientFieldScore = 0
			if CoD.CompetitiveScoreboard.IsDLC4Map == true then
				CoD.CompetitiveScoreboard.UpdateItemDisplay(CompetitiveScoreboardWidget, CompetitiveScoreboardWidget.Scores[ClientScoreIndex], ClientIndex)
			end
			if ClientIndex == ClientInstance.selfindex then
				CoD.CompetitiveScoreboard.CompetitiveScoreShowSelf(CompetitiveScoreboardWidget.Scores[ClientScoreIndex], ClientScoreIndex, 0)
				CompetitiveScoreboardWidget.Scores[ClientScoreIndex].scoreBg:setAlpha(1)
				if CoD.Zombie.IsCharacterNameDisplayMap() == true then
					CoD.CompetitiveScoreboard.UpdateCharacterName(CompetitiveScoreboardWidget, ClientInstance.modelName, CompetitiveScoreboardWidget.Scores[ClientScoreIndex], ClientIndex)
					CoD.CompetitiveScoreboard.CompetitiveScoreTextShowPlayerColor(CompetitiveScoreboardWidget.Scores[ClientScoreIndex].characterName, ClientIndex, 0)
				end
			else
				CoD.CompetitiveScoreboard.CompetitiveScoreShow(CompetitiveScoreboardWidget.Scores[ClientScoreIndex], ClientScoreIndex, 0)
				CompetitiveScoreboardWidget.Scores[ClientScoreIndex].scoreBg:setAlpha(0)
				if CoD.Zombie.IsCharacterNameDisplayMap() == true then
					CoD.CompetitiveScoreboard.ClearCharacterName(CompetitiveScoreboardWidget.Scores[ClientScoreIndex])
				end
			end
			CoD.CompetitiveScoreboard.CompetitiveScoreTextShowPlayerColor(CompetitiveScoreboardWidget.Scores[ClientScoreIndex].scoreText, ClientIndex, 0)
		end
		if CompetitiveScoreboardWidget.currentCompetitiveScoreNum ~= nil and #ClientInstance.competitivescores < CompetitiveScoreboardWidget.currentCompetitiveScoreNum then
			for ClientIndex = #ClientInstance.competitivescores + 1, CompetitiveScoreboardWidget.currentCompetitiveScoreNum, 1 do
				CoD.CompetitiveScoreboard.CompetitiveScoreHide(CompetitiveScoreboardWidget.Scores[ClientIndex], 0)
				CompetitiveScoreboardWidget.Scores[ClientIndex].preScore = 0
				CompetitiveScoreboardWidget.Scores[ClientIndex].currentScore = 0
				CompetitiveScoreboardWidget.Scores[ClientIndex].clientNum = nil
				if CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon then
					CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon.material = nil
					CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon:setAlpha(0)
					CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon.itemState = CoD.CompetitiveScoreboard.NEED_SHOVEL
				end
				if CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon then
					CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon.material = nil
					CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon:setAlpha(0)
					CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon.itemState = CoD.CompetitiveScoreboard.NEED_HELMET
				end
			end
		end
		CompetitiveScoreboardWidget.currentCompetitiveScoreNum = #ClientInstance.competitivescores
	end
end

CoD.CompetitiveScoreboard.Update_ClientFields_FlyingScore = function (CompetitiveScoreboardWidget, ClientInstance)
	local PlayerScoreListWidget = nil
	for PlayerScoreListWidgetIndex = 1, CoD.CompetitiveScoreboard.TeamPlayerCount, 1 do
		if CompetitiveScoreboardWidget.Scores[PlayerScoreListWidgetIndex].clientNum == ClientInstance.entNum then
			PlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[PlayerScoreListWidgetIndex]
			break
		end
	end
	if not PlayerScoreListWidget then
		return 
	elseif ClientInstance.name == CoD.CompetitiveScoreboard.DoublePointsActive_ClientFieldName then
		PlayerScoreListWidget.doublePointsActive = ClientInstance.newValue + 1
	else
		if ClientInstance.initialSnap == true or ClientInstance.newEnt == true or ClientInstance.wasDemoJump == true then
			return 
		end
		local MaxClientFields = nil
		if ClientInstance.oldValue < ClientInstance.newValue then
			MaxClientFields = ClientInstance.newValue - ClientInstance.oldValue
		else
			MaxClientFields = ClientInstance.newValue - ClientInstance.oldValue + CoD.CompetitiveScoreboard.ClientFields[ClientInstance.name].max + 1
		end
		local PlayerScoreListWidget = CoD.CompetitiveScoreboard.GetScore(CompetitiveScoreboardWidget, ClientInstance.entNum)
		if PlayerScoreListWidget ~= nil then
			local ScoreAmount = CoD.CompetitiveScoreboard.ClientFields[ClientInstance.name].scoreScale * PlayerScoreListWidget.doublePointsActive
			for Index = 1, MaxClientFields, 1 do
				CoD.CompetitiveScoreboard.FloatingScoreStart(PlayerScoreListWidget, ScoreAmount)
			end
			PlayerScoreListWidget.currentClientFieldScore = PlayerScoreListWidget.currentClientFieldScore + ScoreAmount * MaxClientFields
		end
	end
end

CoD.CompetitiveScoreboard.FloatingScoreStart = function (PlayerScoreListWidget, ScoreAmount)
	local AvailableFloatingScoreText = CoD.CompetitiveScoreboard.GetFloatingScoreText(PlayerScoreListWidget)
	if AvailableFloatingScoreText ~= nil then
		AvailableFloatingScoreText:setAlpha(1)
		local ScoreText = nil
		if ScoreAmount > 0 then
			ScoreText = "+" .. ScoreAmount
			AvailableFloatingScoreText:setRGB(0.9, 0.9, 0)
		else
			ScoreText = ScoreAmount
			AvailableFloatingScoreText:setRGB(CoD.CompetitiveScoreboard.FloatingLosePointsColor.r, CoD.CompetitiveScoreboard.FloatingLosePointsColor.g, CoD.CompetitiveScoreboard.FloatingLosePointsColor.b)
		end
		AvailableFloatingScoreText:setText(ScoreText)
		AvailableFloatingScoreText.isUsed = true
		local HorizontalOffset = math.random(CoD.CompetitiveScoreboard.FlyingLeftOffSetMin, CoD.CompetitiveScoreboard.FlyingLeftOffSetMax)
		local VerticalOffset = math.random(CoD.CompetitiveScoreboard.FlyingTopOffSetMin, CoD.CompetitiveScoreboard.FlyingTopOffSetMax) - (CoD.CompetitiveScoreboard.FlyingTopOffSetMin + CoD.CompetitiveScoreboard.FlyingTopOffSetMax) * 0.5
		AvailableFloatingScoreText:beginAnimation("flying_out", math.random(CoD.CompetitiveScoreboard.FlyingDurationMin, CoD.CompetitiveScoreboard.FlyingDurationMax))
		AvailableFloatingScoreText:setAlpha(0)
		AvailableFloatingScoreText:setLeftRight(true, false, -HorizontalOffset, -HorizontalOffset + CoD.CompetitiveScoreboard.RowWidth)
		AvailableFloatingScoreText:setTopBottom(true, false, VerticalOffset, VerticalOffset + CoD.CompetitiveScoreboard.RowHeight)
	end
end

CoD.CompetitiveScoreboard.GetScore = function (CompetitiveScoreboardWidget, LocalClientIndex)
	for PlayerScoreListWidgetIndex = 1, CoD.CompetitiveScoreboard.TeamPlayerCount, 1 do
		if CompetitiveScoreboardWidget.Scores[PlayerScoreListWidgetIndex].clientNum == LocalClientIndex then
			return CompetitiveScoreboardWidget.Scores[PlayerScoreListWidgetIndex]
		end
	end
	return nil
end

CoD.CompetitiveScoreboard.GetFloatingScoreText = function (PlayerScoreListWidget)
	for ScoreTextIndex = 1, CoD.CompetitiveScoreboard.ClientFieldMaxValue, 1 do
		if PlayerScoreListWidget.floatingScoreTexts[ScoreTextIndex].isUsed == false then
			return PlayerScoreListWidget.floatingScoreTexts[ScoreTextIndex]
		end
	end
	return nil
end

CoD.CompetitiveScoreboard.FloatingTextFlyingFinish = function (FloatingScoreText, ClientInstance)
	if ClientInstance.interrupted ~= true then
		FloatingScoreText.isUsed = false
		FloatingScoreText:setLeftRight(true, false, 10, 10 + CoD.CompetitiveScoreboard.RowWidth)
		FloatingScoreText:setTopBottom(true, false, 0, CoD.CompetitiveScoreboard.RowHeight)
	end
end

CoD.CompetitiveScoreboard.Update_ClientField_NavCards = function (CompetitiveScoreboardWidget, ClientInstance)
	local PlayerScoreListWidget = CoD.CompetitiveScoreboard.GetScore(CompetitiveScoreboardWidget, ClientInstance.entNum)
	for NavCardIconIndex = 1, CoD.CompetitiveScoreboard.NavCardsCount, 1 do
		if CoD.CompetitiveScoreboard.HasBit(ClientInstance.newValue, CoD.CompetitiveScoreboard.Bit(NavCardIconIndex)) == true then
			if PlayerScoreListWidget ~= nil then
				PlayerScoreListWidget.navCardIcons[NavCardIconIndex]:setImage(CoD.CompetitiveScoreboard.NavCards[NavCardIconIndex])
				PlayerScoreListWidget.navCardIcons[NavCardIconIndex]:setAlpha(1)
				PlayerScoreListWidget.navCardIcons[NavCardIconIndex].material = CoD.CompetitiveScoreboard.NavCards[NavCardIconIndex]
				print("player has bit")
			end
		elseif PlayerScoreListWidget ~= nil then
			PlayerScoreListWidget.navCardIcons[NavCardIconIndex]:setAlpha(0)
			PlayerScoreListWidget.navCardIcons[NavCardIconIndex].material = nil
		end
	end
end

CoD.CompetitiveScoreboard.Update_ClientField_Shovel = function (CompetitiveScoreboardWidget, ClientInstance)
	local ShovelClientFieldState = ClientInstance.newValue
	local ClientFieldNameIndex = tonumber(string.sub(ClientInstance.name, string.len(ClientInstance.name))) - 1
	local PlayerScoreListWidget = CoD.CompetitiveScoreboard.GetScore(CompetitiveScoreboardWidget, ClientFieldNameIndex)
	CoD.CompetitiveScoreboard.ShovelStates[ClientFieldNameIndex + 1] = ShovelClientFieldState
	if not PlayerScoreListWidget then
		return 
	elseif PlayerScoreListWidget.shovelIcon then
		if ShovelClientFieldState == CoD.CompetitiveScoreboard.HAVE_SHOVEL then
			PlayerScoreListWidget.shovelIcon:setImage(CoD.CompetitiveScoreboard.ShovelMaterial)
			PlayerScoreListWidget.shovelIcon:setAlpha(1)
			PlayerScoreListWidget.shovelIcon.material = CoD.CompetitiveScoreboard.ShovelMaterial
			PlayerScoreListWidget.shovelIcon.itemState = CoD.CompetitiveScoreboard.HAVE_SHOVEL
		elseif ShovelClientFieldState == CoD.CompetitiveScoreboard.HAVE_UG_SHOVEL then
			PlayerScoreListWidget.shovelIcon:setImage(CoD.CompetitiveScoreboard.ShovelGoldMaterial)
			PlayerScoreListWidget.shovelIcon:setAlpha(1)
			PlayerScoreListWidget.shovelIcon.material = CoD.CompetitiveScoreboard.ShovelGoldMaterial
			PlayerScoreListWidget.shovelIcon.itemState = CoD.CompetitiveScoreboard.HAVE_UG_SHOVEL
		else
			PlayerScoreListWidget.shovelIcon.material = nil
			PlayerScoreListWidget.shovelIcon:setAlpha(0)
			PlayerScoreListWidget.shovelIcon.itemState = CoD.CompetitiveScoreboard.NEED_SHOVEL
		end
	end
end

CoD.CompetitiveScoreboard.Update_ClientField_Helmet = function (CompetitiveScoreboardWidget, ClientInstance)
	local HelmetClientFieldState = ClientInstance.newValue
	local ClientFieldNameIndex = tonumber(string.sub(ClientInstance.name, string.len(ClientInstance.name))) - 1
	local PlayerScoreListWidget = CoD.CompetitiveScoreboard.GetScore(CompetitiveScoreboardWidget, ClientFieldNameIndex)
	CoD.CompetitiveScoreboard.HelmetStates[ClientFieldNameIndex + 1] = HelmetClientFieldState
	if not PlayerScoreListWidget then
		return 
	elseif PlayerScoreListWidget.helmetIcon then
		if HelmetClientFieldState == CoD.CompetitiveScoreboard.HAVE_HELMET then
			PlayerScoreListWidget.helmetIcon:setImage(CoD.CompetitiveScoreboard.HardHatMaterial)
			PlayerScoreListWidget.helmetIcon:setAlpha(1)
			PlayerScoreListWidget.helmetIcon.material = CoD.CompetitiveScoreboard.HardHatMaterial
			PlayerScoreListWidget.helmetIcon.itemState = CoD.CompetitiveScoreboard.HAVE_HELMET
		else
			PlayerScoreListWidget.helmetIcon.material = nil
			PlayerScoreListWidget.helmetIcon:setAlpha(0)
			PlayerScoreListWidget.helmetIcon.itemState = CoD.CompetitiveScoreboard.NEED_HELMET
		end
	end
end

CoD.CompetitiveScoreboard.Bit = function (Index)
	return 2 ^ (Index - 1)
end

CoD.CompetitiveScoreboard.HasBit = function (ClientFieldValue, NavCardBit)
	return NavCardBit <= (ClientFieldValue % (NavCardBit + NavCardBit))
end

CoD.CompetitiveScoreboard.UpdateCharacterName = function (CompetitiveScoreboardWidget, ClientInstanceModelName, PlayerScoreListWidget, LocalClientIndex)
	if not ClientInstanceModelName and PlayerScoreListWidget.characterName then
		PlayerScoreListWidget.characterName:setText("")
		return 
	elseif UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_SPECTATING_CLIENT) == 1 then
		return 
	elseif PlayerScoreListWidget.playerModelName ~= ClientInstanceModelName then
		local CharacterNameIndex = 0
		for CharacterModelNameIndex = 1, #CoD.CompetitiveScoreboard.CharacterNames, 1 do
			if ClientInstanceModelName == CoD.CompetitiveScoreboard.CharacterNames[CharacterModelNameIndex].modelName then
				CharacterNameIndex = CharacterModelNameIndex
				break
			end
		end
		if CharacterNameIndex > 0 and PlayerScoreListWidget.characterName then
			PlayerScoreListWidget.characterName:setText(CoD.CompetitiveScoreboard.CharacterNames[CharacterNameIndex].name)
			PlayerScoreListWidget.playerModelName = ClientInstanceModelName
			if CoD.CompetitiveScoreboard.IsDLC3Map == true then
				PlayerScoreListWidget.characterName.fadeOutTimer = LUI.UITimer.new(CoD.CompetitiveScoreboard.CHARACTER_NAME_ONSCREEN_DURATION, "character_name_fade_out", true, CompetitiveScoreboardWidget)
				PlayerScoreListWidget.characterName:addElement(PlayerScoreListWidget.characterName.fadeOutTimer)
			end
		end
	end
end

CoD.CompetitiveScoreboard.FadeoutCharacterName = function (CharacterNameWidget, ClientInstance)
	CharacterNameWidget:beginAnimation("fade_out", CoD.CompetitiveScoreboard.CHARACTER_NAME_FADE_OUT_DURATION)
	CharacterNameWidget:setAlpha(0)
end

CoD.CompetitiveScoreboard.ClearCharacterName = function (PlayerScoreListWidget)
	if PlayerScoreListWidget.playerModelName then
		PlayerScoreListWidget.playerModelName = nil
		PlayerScoreListWidget.characterName:setText("")
	end
end



CoD.CompetitiveScoreboard.CompetitiveScoreShowSelf = function (PlayerScoreListWidget, ClientScoreIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end

	PlayerScoreListWidget:beginAnimation("showself_hide", AnimDelay)
	PlayerScoreListWidget:setAlpha(0)
end


CoD.CompetitiveScoreboard.Update = function (CompetitiveScoreboardWidget, ClientInstance)
	local shownCount = 0
	local totalPlayers = #ClientInstance.competitivescores

	if totalPlayers <= #CompetitiveScoreboardWidget.Scores then
		for ClientIndex, LocalClient in pairs(ClientInstance.competitivescores) do
			if ClientIndex ~= ClientInstance.selfindex then
				shownCount = shownCount + 1

				local ClientScoreIndex = totalPlayers - shownCount + 1
				local PlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[ClientScoreIndex]

				if PlayerScoreListWidget then
					PlayerScoreListWidget.scoreText:setText(LocalClient.score)

					if CoD.Zombie.IsSideQuestMap(Dvar.ui_mapname:get()) then
						CoD.CompetitiveScoreboard.CopyPreNavCardAndShow(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient.clientNum)
					end

					local ClientNumsAreSame = PlayerScoreListWidget.clientNum ~= LocalClient.clientNum
					PlayerScoreListWidget.preScore = CompetitiveScoreboardWidget.Scores[ClientScoreIndex].currentScore
					PlayerScoreListWidget.currentScore = LocalClient.score
					PlayerScoreListWidget.clientNum = LocalClient.clientNum

					local ScoreAmount = PlayerScoreListWidget.currentScore - PlayerScoreListWidget.preScore - PlayerScoreListWidget.currentClientFieldScore
					if ScoreAmount ~= 0 and ClientInstance.bWasDemoJump == false and ClientNumsAreSame == false then
						CoD.CompetitiveScoreboard.FloatingScoreStart(PlayerScoreListWidget, ScoreAmount)
					end
					PlayerScoreListWidget.currentClientFieldScore = 0

					if CoD.CompetitiveScoreboard.IsDLC4Map == true then
						CoD.CompetitiveScoreboard.UpdateItemDisplay(CompetitiveScoreboardWidget, CompetitiveScoreboardWidget.Scores[ClientScoreIndex], ClientIndex)
					end

					CoD.CompetitiveScoreboard.CompetitiveScoreShow(CompetitiveScoreboardWidget.Scores[ClientScoreIndex], ClientScoreIndex, 0)
					CompetitiveScoreboardWidget.Scores[ClientScoreIndex].scoreBg:setAlpha(0)

					if CoD.Zombie.IsCharacterNameDisplayMap() == true then
						CoD.CompetitiveScoreboard.ClearCharacterName(CompetitiveScoreboardWidget.Scores[ClientScoreIndex])
					end

					CoD.CompetitiveScoreboard.CompetitiveScoreTextShowPlayerColor(CompetitiveScoreboardWidget.Scores[ClientScoreIndex].scoreText, ClientIndex, 0)
				end
			end
		end

		local firstHiddenIndex = totalPlayers - shownCount
		if firstHiddenIndex < 1 then
			firstHiddenIndex = 1
		end

		for ClientIndex = 1, firstHiddenIndex, 1 do
			if CompetitiveScoreboardWidget.Scores[ClientIndex] then
				CoD.CompetitiveScoreboard.CompetitiveScoreHide(CompetitiveScoreboardWidget.Scores[ClientIndex], 0)
				CompetitiveScoreboardWidget.Scores[ClientIndex].preScore = 0
				CompetitiveScoreboardWidget.Scores[ClientIndex].currentScore = 0
				CompetitiveScoreboardWidget.Scores[ClientIndex].clientNum = nil

				if CompetitiveScoreboardWidget.Scores[ClientIndex].scoreText then
					CompetitiveScoreboardWidget.Scores[ClientIndex].scoreText:setText("")
				end

				if CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon then
					CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon.material = nil
					CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon:setAlpha(0)
					CompetitiveScoreboardWidget.Scores[ClientIndex].shovelIcon.itemState = CoD.CompetitiveScoreboard.NEED_SHOVEL
				end

				if CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon then
					CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon.material = nil
					CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon:setAlpha(0)
					CompetitiveScoreboardWidget.Scores[ClientIndex].helmetIcon.itemState = CoD.CompetitiveScoreboard.NEED_HELMET
				end
			end
		end

		if CompetitiveScoreboardWidget.currentCompetitiveScoreNum ~= nil and totalPlayers < CompetitiveScoreboardWidget.currentCompetitiveScoreNum then
			for ClientIndex = totalPlayers + 1, CompetitiveScoreboardWidget.currentCompetitiveScoreNum, 1 do
				if CompetitiveScoreboardWidget.Scores[ClientIndex] then
					CoD.CompetitiveScoreboard.CompetitiveScoreHide(CompetitiveScoreboardWidget.Scores[ClientIndex], 0)
					CompetitiveScoreboardWidget.Scores[ClientIndex].preScore = 0
					CompetitiveScoreboardWidget.Scores[ClientIndex].currentScore = 0
					CompetitiveScoreboardWidget.Scores[ClientIndex].clientNum = nil

					if CompetitiveScoreboardWidget.Scores[ClientIndex].scoreText then
						CompetitiveScoreboardWidget.Scores[ClientIndex].scoreText:setText("")
					end
				end
			end
		end

		CompetitiveScoreboardWidget.currentCompetitiveScoreNum = totalPlayers
	end
end

local function T5TeamScoreEnabled()
	local value = UIExpression.DvarString(nil, "t5_setting_team_score")
	return value == nil or value == "" or tostring(value) ~= "0"
end

CoD.CompetitiveScoreboard.UpdateVisibility = function (CompetitiveScoreboardWidget, ClientInstance)
	local LocalClientIndex = ClientInstance.controller
	local visible =
		T5TeamScoreEnabled() and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_HUD_VISIBLE) == 1 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IS_PLAYER_IN_AFTERLIFE) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_EMP_ACTIVE) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IN_VEHICLE) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IN_GUIDED_MISSILE) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IS_FLASH_BANGED) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_UI_ACTIVE) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_SCOREBOARD_OPEN) == 0 and
		UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_IS_SCOPED) == 0 and
		(not CoD.IsShoutcaster(LocalClientIndex) or CoD.IsShoutcasterProfileVariableTrue(LocalClientIndex, "shoutcaster_scorestreaks") and Engine.IsSpectatingActiveClient(LocalClientIndex)) and
		CoD.FSM_VISIBILITY(LocalClientIndex) == 0

	if visible then
		if CompetitiveScoreboardWidget.visible ~= true then
			CompetitiveScoreboardWidget:setAlpha(1)
			CompetitiveScoreboardWidget.m_inputDisabled = nil
			CompetitiveScoreboardWidget.visible = true
		end
	elseif CompetitiveScoreboardWidget.visible == true then
		CompetitiveScoreboardWidget:setAlpha(0)
		CompetitiveScoreboardWidget.m_inputDisabled = true
		CompetitiveScoreboardWidget.visible = nil
	end

	CompetitiveScoreboardWidget:dispatchEventToChildren(ClientInstance)
end

CoD.CompetitiveScoreboard.BackGroundMaterial = RegisterMaterial("t5_scorebar_zom_1")
CoD.CompetitiveScoreboard.T5SelfLeft = 1124
CoD.CompetitiveScoreboard.T5SelfTop = 552
CoD.CompetitiveScoreboard.T5SelfWidth = 152
CoD.CompetitiveScoreboard.T5SelfHeight = 41
CoD.CompetitiveScoreboard.T5OtherLeft = 1124
CoD.CompetitiveScoreboard.T5OtherScale = 0.6
CoD.CompetitiveScoreboard.T5OtherGap = 3
CoD.CompetitiveScoreboard.T5OtherStartTop = CoD.CompetitiveScoreboard.T5SelfTop - ((CoD.CompetitiveScoreboard.T5SelfHeight * CoD.CompetitiveScoreboard.T5OtherScale) + CoD.CompetitiveScoreboard.T5OtherGap)

local function T5SetScoreTextStyle(PlayerScoreListWidget)
	if PlayerScoreListWidget == nil then
		return
	end

	if PlayerScoreListWidget.scoreBg ~= nil then
		PlayerScoreListWidget.scoreBg:setImage(CoD.CompetitiveScoreboard.BackGroundMaterial)
		PlayerScoreListWidget.scoreBg:setRGB( 0.45, 0, 0 )
		PlayerScoreListWidget.scoreBg:setAlpha(1)
		PlayerScoreListWidget.scoreBg:setPriority(-10)
	end

	if PlayerScoreListWidget.scoreText ~= nil then
		PlayerScoreListWidget.scoreText:setPriority(10)
		PlayerScoreListWidget.scoreText:setFont(CoD.fonts.Default)
		PlayerScoreListWidget.scoreText:setAlignment(LUI.Alignment.Left)
		PlayerScoreListWidget.scoreText:setLeftRight(true, false, 10, 60)
		PlayerScoreListWidget.scoreText:setTopBottom(true, false, 11, 39)
		PlayerScoreListWidget.scoreText:setScale(1.17)
	end
end

CoD.CompetitiveScoreboard.CompetitiveScoreShowSelf = function(PlayerScoreListWidget, ClientScoreIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end

	T5SetScoreTextStyle(PlayerScoreListWidget)
	PlayerScoreListWidget:beginAnimation("showself_t5", AnimDelay)
	PlayerScoreListWidget:setScale(1)
	PlayerScoreListWidget:setLeftRight(true, false, CoD.CompetitiveScoreboard.T5SelfLeft, CoD.CompetitiveScoreboard.T5SelfLeft + CoD.CompetitiveScoreboard.T5SelfWidth)
	PlayerScoreListWidget:setTopBottom(true, false, CoD.CompetitiveScoreboard.T5SelfTop, CoD.CompetitiveScoreboard.T5SelfTop + CoD.CompetitiveScoreboard.T5SelfHeight)
	PlayerScoreListWidget:setAlpha(1)
end

CoD.CompetitiveScoreboard.CompetitiveScoreShow = function(PlayerScoreListWidget, OtherScoreIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end

	local top = CoD.CompetitiveScoreboard.T5OtherStartTop - ((CoD.CompetitiveScoreboard.T5SelfHeight * CoD.CompetitiveScoreboard.T5OtherScale + CoD.CompetitiveScoreboard.T5OtherGap) * (OtherScoreIndex - 1))

	T5SetScoreTextStyle(PlayerScoreListWidget)
	PlayerScoreListWidget:beginAnimation("show_t5", AnimDelay)
	PlayerScoreListWidget:setScale(CoD.CompetitiveScoreboard.T5OtherScale)
	PlayerScoreListWidget:setLeftRight(true, false, CoD.CompetitiveScoreboard.T5OtherLeft, CoD.CompetitiveScoreboard.T5OtherLeft + CoD.CompetitiveScoreboard.T5SelfWidth)
	PlayerScoreListWidget:setTopBottom(true, false, top, top + CoD.CompetitiveScoreboard.T5SelfHeight)
	PlayerScoreListWidget:setAlpha(1)
end

local function T5UpdateScoreWidget(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient, ClientIndex, ClientInstance)
	if PlayerScoreListWidget == nil or LocalClient == nil then
		return
	end

	PlayerScoreListWidget.scoreText:setText(LocalClient.score)

	if CoD.Zombie.IsSideQuestMap(Dvar.ui_mapname:get()) then
		CoD.CompetitiveScoreboard.CopyPreNavCardAndShow(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient.clientNum)
	end

	local ClientNumsAreSame = PlayerScoreListWidget.clientNum ~= LocalClient.clientNum
	PlayerScoreListWidget.preScore = PlayerScoreListWidget.currentScore
	PlayerScoreListWidget.currentScore = LocalClient.score
	PlayerScoreListWidget.clientNum = LocalClient.clientNum

	local ScoreAmount = PlayerScoreListWidget.currentScore - PlayerScoreListWidget.preScore - PlayerScoreListWidget.currentClientFieldScore
	if ScoreAmount ~= 0 and ClientInstance.bWasDemoJump == false and ClientNumsAreSame == false then
		CoD.CompetitiveScoreboard.FloatingScoreStart(PlayerScoreListWidget, ScoreAmount)
	end

	PlayerScoreListWidget.currentClientFieldScore = 0

	if CoD.CompetitiveScoreboard.IsDLC4Map == true then
		CoD.CompetitiveScoreboard.UpdateItemDisplay(CompetitiveScoreboardWidget, PlayerScoreListWidget, ClientIndex)
	end

	CoD.CompetitiveScoreboard.CompetitiveScoreTextShowPlayerColor(PlayerScoreListWidget.scoreText, ClientIndex, 0)
end

CoD.CompetitiveScoreboard.Update = function(CompetitiveScoreboardWidget, ClientInstance)
	if ClientInstance.competitivescores == nil or #ClientInstance.competitivescores > #CompetitiveScoreboardWidget.Scores then
		return
	end

	local usedWidgets = 0
	local selfWidget = CompetitiveScoreboardWidget.Scores[1]
	local otherShown = 0

	for ClientIndex, LocalClient in pairs(ClientInstance.competitivescores) do
		if ClientIndex == ClientInstance.selfindex then
			usedWidgets = math.max(usedWidgets, 1)
			T5UpdateScoreWidget(CompetitiveScoreboardWidget, selfWidget, LocalClient, ClientIndex, ClientInstance)
			CoD.CompetitiveScoreboard.CompetitiveScoreShowSelf(selfWidget, 1, 0)
			if CoD.Zombie.IsCharacterNameDisplayMap() == true then
				CoD.CompetitiveScoreboard.ClearCharacterName(selfWidget)
			end
		end
	end

	for ClientIndex, LocalClient in pairs(ClientInstance.competitivescores) do
		if ClientIndex ~= ClientInstance.selfindex then
			otherShown = otherShown + 1
			local widgetIndex = otherShown + 1
			local PlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[widgetIndex]

			if PlayerScoreListWidget ~= nil then
				usedWidgets = math.max(usedWidgets, widgetIndex)
				T5UpdateScoreWidget(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient, ClientIndex, ClientInstance)
				CoD.CompetitiveScoreboard.CompetitiveScoreShow(PlayerScoreListWidget, otherShown, 0)
				if CoD.Zombie.IsCharacterNameDisplayMap() == true then
					CoD.CompetitiveScoreboard.ClearCharacterName(PlayerScoreListWidget)
				end
			end
		end
	end

	for ClientIndex = usedWidgets + 1, #CompetitiveScoreboardWidget.Scores do
		local PlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[ClientIndex]
		if PlayerScoreListWidget ~= nil then
			CoD.CompetitiveScoreboard.CompetitiveScoreHide(PlayerScoreListWidget, 0)
			PlayerScoreListWidget.preScore = 0
			PlayerScoreListWidget.currentScore = 0
			PlayerScoreListWidget.currentClientFieldScore = 0
			PlayerScoreListWidget.clientNum = nil

			if PlayerScoreListWidget.scoreText ~= nil then
				PlayerScoreListWidget.scoreText:setText("")
			end
		end
	end

	CompetitiveScoreboardWidget.currentCompetitiveScoreNum = usedWidgets
end

CoD.CompetitiveScoreboard.T5ScoreBarMaterials = {
	RegisterMaterial("t5_scorebar_zom_1"),
	RegisterMaterial("t5_scorebar_zom_2"),
	RegisterMaterial("t5_scorebar_zom_3"),
	RegisterMaterial("t5_scorebar_zom_4")
}

CoD.CompetitiveScoreboard.T5ScoreBarColor = {
	r = 0.45,
	g = 0,
	b = 0
}

CoD.CompetitiveScoreboard.T5SelfBounds = {
	left = -155,
	right = -4,
	top = 552,
	bottom = 592.5
}

CoD.CompetitiveScoreboard.T5OtherBounds = {
	[1] = {
		left = -155,
		right = -34,
		top = 521.5,
		bottom = 558
	},
	[2] = {
		left = -155,
		right = -34,
		top = 489,
		bottom = 525.5
	},
	[3] = {
		left = -155,
		right = -34,
		top = 456.5,
		bottom = 493
	},
	[4] = {
		left = -155,
		right = -34,
		top = 424,
		bottom = 460.5
	},
	[5] = {
		left = -155,
		right = -34,
		top = 391.5,
		bottom = 428
	},
	[6] = {
		left = -155,
		right = -34,
		top = 359,
		bottom = 395.5
	},
	[7] = {
		left = -155,
		right = -34,
		top = 326.5,
		bottom = 363
	}
}

local function T5GetScorebarMaterial(clientNum)
	local materialIndex = 1

	if clientNum ~= nil then
		materialIndex = (tonumber(clientNum) or 0) + 1
	end

	if materialIndex < 1 then
		materialIndex = 1
	elseif materialIndex > 4 then
		materialIndex = ((materialIndex - 1) % 4) + 1
	end

	return CoD.CompetitiveScoreboard.T5ScoreBarMaterials[materialIndex]
end

CoD.CompetitiveScoreboard.T5FallbackPlayerColors = {
	{ r = 1, g = 1, b = 1 },
	{ r = 0.49, g = 0.81, b = 0.93 },
	{ r = 0.96, g = 0.79, b = 0.31 },
	{ r = 0.51, g = 0.93, b = 0.53 }
}

local function T5GetSharedScoreColorOrder()
	if CoD.T5SharedScoreColorOrder == nil then
		CoD.T5SharedScoreColorOrder = { 1, 2, 3, 4 }

		if math ~= nil and math.random ~= nil then
			for colorIndex = #CoD.T5SharedScoreColorOrder, 2, -1 do
				local swapIndex = math.random(colorIndex)
				local tempColor = CoD.T5SharedScoreColorOrder[colorIndex]
				CoD.T5SharedScoreColorOrder[colorIndex] = CoD.T5SharedScoreColorOrder[swapIndex]
				CoD.T5SharedScoreColorOrder[swapIndex] = tempColor
			end
		end
	end

	return CoD.T5SharedScoreColorOrder
end

local function T5GetScoreColorIndexForPlayerOrder(playerOrderIndex)
	local numericIndex = tonumber(playerOrderIndex)
	if numericIndex == nil or numericIndex < 1 then
		numericIndex = 1
	end

	local colorOrder = T5GetSharedScoreColorOrder()
	return colorOrder[((numericIndex - 1) % 4) + 1] or 1
end

local function T5GetPlayerColorFromColorIndex(colorIndex)
	local colorTable = nil

	if CoD ~= nil and CoD.Zombie ~= nil and CoD.Zombie.PlayerColors ~= nil then
		colorTable = CoD.Zombie.PlayerColors[colorIndex]
	end

	if colorTable == nil then
		colorTable = CoD.CompetitiveScoreboard.T5FallbackPlayerColors[colorIndex]
	end

	if colorTable == nil then
		colorTable = CoD.CompetitiveScoreboard.T5FallbackPlayerColors[1]
	end

	return colorTable.r, colorTable.g, colorTable.b
end

local function T5ApplyScoreTextPlayerColor(Text, colorIndex, AnimDelay)
	if Text == nil then
		return
	end

	if not AnimDelay then
		AnimDelay = 0
	end

	local r, g, b = T5GetPlayerColorFromColorIndex(colorIndex)
	Text:beginAnimation("showsharedcolor_t5", AnimDelay)
	Text:setRGB(r, g, b)
end

local function T5ApplyScorebarStyle(PlayerScoreListWidget, LocalClient, isSelf, colorIndex)
	if PlayerScoreListWidget == nil then
		return
	end

	if PlayerScoreListWidget.scoreBg ~= nil then
		PlayerScoreListWidget.scoreBg:setImage(CoD.CompetitiveScoreboard.T5ScoreBarMaterials[colorIndex] or CoD.CompetitiveScoreboard.T5ScoreBarMaterials[1])
		PlayerScoreListWidget.scoreBg:setRGB(
			CoD.CompetitiveScoreboard.T5ScoreBarColor.r,
			CoD.CompetitiveScoreboard.T5ScoreBarColor.g,
			CoD.CompetitiveScoreboard.T5ScoreBarColor.b
		)
		PlayerScoreListWidget.scoreBg:setAlpha(1)
		PlayerScoreListWidget.scoreBg:setLeftRight(true, true, 0, 0)
		PlayerScoreListWidget.scoreBg:setTopBottom(true, true, 0, 0)
	end

	if PlayerScoreListWidget.scoreText ~= nil then
		PlayerScoreListWidget.scoreText:setFont(CoD.fonts.Default)
		PlayerScoreListWidget.scoreText:setAlignment(LUI.Alignment.Left)
		PlayerScoreListWidget.scoreText:setAlpha(1)

		if isSelf == true then
			PlayerScoreListWidget.scoreText:setLeftRight(true, false, 14, 95)
			PlayerScoreListWidget.scoreText:setTopBottom(true, false, 8, 38)
			PlayerScoreListWidget.scoreText:setScale(1.17)
		else
			PlayerScoreListWidget.scoreText:setLeftRight(true, false, 12, 82)
			PlayerScoreListWidget.scoreText:setTopBottom(true, false, 7, 34)
			PlayerScoreListWidget.scoreText:setScale(1.02)
		end
	end
end

CoD.CompetitiveScoreboard.CompetitiveScoreShowSelf = function(PlayerScoreListWidget, ClientScoreIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end

	PlayerScoreListWidget:beginAnimation("showself_t5_exact", AnimDelay)
	PlayerScoreListWidget:setScale(1)
	PlayerScoreListWidget:setLeftRight(
		false,
		true,
		CoD.CompetitiveScoreboard.T5SelfBounds.left,
		CoD.CompetitiveScoreboard.T5SelfBounds.right
	)
	PlayerScoreListWidget:setTopBottom(
		true,
		false,
		CoD.CompetitiveScoreboard.T5SelfBounds.top,
		CoD.CompetitiveScoreboard.T5SelfBounds.bottom
	)
	PlayerScoreListWidget:setAlpha(1)
end

CoD.CompetitiveScoreboard.CompetitiveScoreShow = function(PlayerScoreListWidget, OtherScoreIndex, AnimDelay)
	if not AnimDelay then
		AnimDelay = 0
	end

	local bounds = CoD.CompetitiveScoreboard.T5OtherBounds[OtherScoreIndex]
	if bounds == nil then
		bounds = CoD.CompetitiveScoreboard.T5OtherBounds[3]
	end

	PlayerScoreListWidget:beginAnimation("show_t5_exact", AnimDelay)
	PlayerScoreListWidget:setScale(1)
	PlayerScoreListWidget:setLeftRight(false, true, bounds.left, bounds.right)
	PlayerScoreListWidget:setTopBottom(true, false, bounds.top, bounds.bottom)
	PlayerScoreListWidget:setAlpha(1)
end

local function T5UpdateScoreWidgetExact(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient, ClientIndex, ClientInstance, isSelf, colorIndex)
	if PlayerScoreListWidget == nil or LocalClient == nil then
		return
	end

	T5ApplyScorebarStyle(PlayerScoreListWidget, LocalClient, isSelf, colorIndex)
	PlayerScoreListWidget.scoreText:setText(LocalClient.score)

	if CoD.Zombie.IsSideQuestMap(Dvar.ui_mapname:get()) then
		CoD.CompetitiveScoreboard.CopyPreNavCardAndShow(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient.clientNum)
	end

	local ClientNumsAreSame = PlayerScoreListWidget.clientNum ~= LocalClient.clientNum
	PlayerScoreListWidget.preScore = PlayerScoreListWidget.currentScore
	PlayerScoreListWidget.currentScore = LocalClient.score
	PlayerScoreListWidget.clientNum = LocalClient.clientNum

	local ScoreAmount = PlayerScoreListWidget.currentScore - PlayerScoreListWidget.preScore - PlayerScoreListWidget.currentClientFieldScore
	if ScoreAmount ~= 0 and ClientInstance.bWasDemoJump == false and ClientNumsAreSame == false then
		CoD.CompetitiveScoreboard.FloatingScoreStart(PlayerScoreListWidget, ScoreAmount)
	end

	PlayerScoreListWidget.currentClientFieldScore = 0

	if CoD.CompetitiveScoreboard.IsDLC4Map == true then
		CoD.CompetitiveScoreboard.UpdateItemDisplay(CompetitiveScoreboardWidget, PlayerScoreListWidget, ClientIndex)
	end

	T5ApplyScoreTextPlayerColor(PlayerScoreListWidget.scoreText, colorIndex, 0)
end

CoD.CompetitiveScoreboard.Update = function(CompetitiveScoreboardWidget, ClientInstance)
	if ClientInstance.competitivescores == nil or #ClientInstance.competitivescores > #CompetitiveScoreboardWidget.Scores then
		return
	end

	local usedWidgets = 0
	local selfWidget = CompetitiveScoreboardWidget.Scores[1]
	local otherShown = 0

	for ClientIndex, LocalClient in pairs(ClientInstance.competitivescores) do
		if ClientIndex == ClientInstance.selfindex then
			usedWidgets = math.max(usedWidgets, 1)
			T5UpdateScoreWidgetExact(CompetitiveScoreboardWidget, selfWidget, LocalClient, ClientIndex, ClientInstance, true, T5GetScoreColorIndexForPlayerOrder(ClientIndex))
			CoD.CompetitiveScoreboard.CompetitiveScoreShowSelf(selfWidget, 1, 0)

			if CoD.Zombie.IsCharacterNameDisplayMap() == true then
				CoD.CompetitiveScoreboard.ClearCharacterName(selfWidget)
			end
		end
	end

	for ClientIndex, LocalClient in pairs(ClientInstance.competitivescores) do
		if ClientIndex ~= ClientInstance.selfindex then
			otherShown = otherShown + 1
			local widgetIndex = otherShown + 1
			local PlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[widgetIndex]

			if PlayerScoreListWidget ~= nil then
				usedWidgets = math.max(usedWidgets, widgetIndex)
				T5UpdateScoreWidgetExact(CompetitiveScoreboardWidget, PlayerScoreListWidget, LocalClient, ClientIndex, ClientInstance, false, T5GetScoreColorIndexForPlayerOrder(ClientIndex))
				CoD.CompetitiveScoreboard.CompetitiveScoreShow(PlayerScoreListWidget, otherShown, 0)

				if CoD.Zombie.IsCharacterNameDisplayMap() == true then
					CoD.CompetitiveScoreboard.ClearCharacterName(PlayerScoreListWidget)
				end
			end
		end
	end

	for ClientIndex = usedWidgets + 1, #CompetitiveScoreboardWidget.Scores do
		local PlayerScoreListWidget = CompetitiveScoreboardWidget.Scores[ClientIndex]
		if PlayerScoreListWidget ~= nil then
			CoD.CompetitiveScoreboard.CompetitiveScoreHide(PlayerScoreListWidget, 0)
			PlayerScoreListWidget.preScore = 0
			PlayerScoreListWidget.currentScore = 0
			PlayerScoreListWidget.currentClientFieldScore = 0
			PlayerScoreListWidget.clientNum = nil

			if PlayerScoreListWidget.scoreText ~= nil then
				PlayerScoreListWidget.scoreText:setText("")
			end

			if PlayerScoreListWidget.scoreBg ~= nil then
				PlayerScoreListWidget.scoreBg:setAlpha(0)
			end
		end
	end

	CompetitiveScoreboardWidget.currentCompetitiveScoreNum = usedWidgets
end
