local SCOREBOARD_BACKGROUND_OPACITY = 0.7
local SCOREBOARD_COLUMN_BACKGROUND_OPACITY = 0.2
local f0_local6 = 337
local f0_local7 = 66
local ScoreboardWidgetCreateTeamElement = nil
local SCOREBOARD_FACTION_ICON_OPACITY = 0.3
local f0_local10 = 32
local SCOREBOARD_TIMER_FONT = "Condensed"
local SCOREBOARD_DEFAULT_MAX_COLUMNS = 5
local f0_local14 = 0
local SCOREBOARD_PING_BARS = {}
local f0_local16 = 232
local SCOREBOARD_ROW_SELECTED = { name = "row_selected" }
local ScoreboardWidgetRowSelectorFunc = nil
local f0_local24 = 27
local f0_local25 = 18
local f0_local26 = f0_local24
local f0_local27 = -35
local SCOREBOARD_COLUMN_FONT = "ExtraSmall"
local f0_local29 = f0_local24
local f0_local30 = 190 - f0_local24
local f0_local31 = 2
local f0_local32 = 4
local ScoreboardUpdateTeamElement, ScoreboardWidgetShowGamercardFunc = nil, nil
local f0_local36 = 460
local ScoreboardWidgetToggleMuteFunc, f0_local38, ScoreboardWidgetUpdateFunc = nil, nil, nil
local f0_local40 = CoD.MPZM(0, 4 * f0_local29)
local f0_local41 = f0_local40
local SCOREBOARD_MAX_ROWS = CoD.MPZM(23, 8)
local IsDLCMap2, IsDLCMap4, IsClassic = nil, nil, nil

local SCOREBOARD_ROW_START_Y = 280
local SCOREBOARD_ROW_HEIGHT = 26
local SCOREBOARD_ROW_GAP = 6
local SCOREBOARD_ROW_X = 283
local SCOREBOARD_ROW_RIGHT = 996
local SCOREBOARD_NAME_LEFT = 279
local SCOREBOARD_NAME_RIGHT = 570
local SCOREBOARD_ROW_TEXT_TOP = 3
local SCOREBOARD_ROW_TEXT_BOTTOM = 25
local SCOREBOARD_NAME_TOP = -2
local SCOREBOARD_NAME_BOTTOM = 29
local SCOREBOARD_HEADER_TOP = 255
local SCOREBOARD_HEADER_BOTTOM = 278
local SCOREBOARD_FONT = "ExtraSmall"
local SCOREBOARD_NAME_SCALE = 0.9
local SCOREBOARD_COLUMNS = {
	{ header = "Points", key = "points", fallbackColumn = 0, left = 578, right = 628 },
	{ header = "Kills", key = "kills", fallbackColumn = 1, left = 651, right = 701 },
	{ header = "Downs", key = "downs", fallbackColumn = 2, left = 723, right = 775 },
	{ header = "Revives", key = "revives", fallbackColumn = 3, left = 789, right = 849 },
	{ header = "Headshots", key = "headshots", fallbackColumn = 4, left = 855, right = 932 }
}
local SCOREBOARD_PING = { header = "Ping", left = 940, right = 990 }

local SCOREBOARD_ROW_NORMAL_R = 0.45
local SCOREBOARD_ROW_NORMAL_G = 0
local SCOREBOARD_ROW_NORMAL_B = 0
local SCOREBOARD_ROW_FOCUSED_R = 0.65
local SCOREBOARD_ROW_FOCUSED_G = 0
local SCOREBOARD_ROW_FOCUSED_B = 0
local SCOREBOARD_ROW_ALPHA = 0.5
local SCOREBOARD_COLOR_SHUFFLE_COUNTER = 0
local SCOREBOARD_LAST_FIRST_COLOR = nil
local SCOREBOARD_FALLBACK_PLAYER_COLORS = {
	{ r = 1, g = 1, b = 1 },
	{ r = 0.49, g = 0.81, b = 0.93 },
	{ r = 0.96, g = 0.79, b = 0.31 },
	{ r = 0.51, g = 0.93, b = 0.53 }
}

local GetPlayerColor = function (ColorIndex)
	local ColorTable = nil
	if CoD ~= nil and CoD.Zombie ~= nil and CoD.Zombie.PlayerColors ~= nil then
		ColorTable = CoD.Zombie.PlayerColors[ColorIndex]
	end
	if ColorTable == nil then
		ColorTable = SCOREBOARD_FALLBACK_PLAYER_COLORS[ColorIndex]
	end
	if ColorTable == nil then
		ColorTable = SCOREBOARD_FALLBACK_PLAYER_COLORS[1]
	end
	return ColorTable.r, ColorTable.g, ColorTable.b
end

local GetColorOrder = function ()
	if CoD.T5SharedScoreColorOrder == nil then
		CoD.T5SharedScoreColorOrder = { 1, 2, 3, 4 }

		if math ~= nil and math.random ~= nil then
			for ColorIndex = #CoD.T5SharedScoreColorOrder, 2, -1 do
				local SwapIndex = math.random(ColorIndex)
				local TempColor = CoD.T5SharedScoreColorOrder[ColorIndex]
				CoD.T5SharedScoreColorOrder[ColorIndex] = CoD.T5SharedScoreColorOrder[SwapIndex]
				CoD.T5SharedScoreColorOrder[SwapIndex] = TempColor
			end
		end
	end

	return CoD.T5SharedScoreColorOrder
end

local GetPlayerColorId = function (PlayerOrderIndex)
	local NumericIndex = tonumber(PlayerOrderIndex)
	if NumericIndex == nil or NumericIndex < 1 then
		NumericIndex = 1
	end

	local ColorOrder = GetColorOrder()
	return ColorOrder[((NumericIndex - 1) % 4) + 1] or 1
end

local MakeColorOrder = function ()
	local ColorOrder = { 1, 2, 3, 4 }
	SCOREBOARD_COLOR_SHUFFLE_COUNTER = SCOREBOARD_COLOR_SHUFFLE_COUNTER + 1
	if math ~= nil and math.random ~= nil then
		if math.randomseed ~= nil and os ~= nil and os.time ~= nil then
			math.randomseed(os.time() + SCOREBOARD_COLOR_SHUFFLE_COUNTER * 97)
			math.random()
			math.random()
		end
		for ColorIndex = #ColorOrder, 2, -1 do
			local SwapIndex = math.random(ColorIndex)
			local TempColor = ColorOrder[ColorIndex]
			ColorOrder[ColorIndex] = ColorOrder[SwapIndex]
			ColorOrder[SwapIndex] = TempColor
		end
		if SCOREBOARD_LAST_FIRST_COLOR ~= nil and ColorOrder[1] == SCOREBOARD_LAST_FIRST_COLOR and #ColorOrder > 1 then
			local TempColor = ColorOrder[1]
			ColorOrder[1] = ColorOrder[2]
			ColorOrder[2] = TempColor
		end
	else
		local ShiftAmount = SCOREBOARD_COLOR_SHUFFLE_COUNTER % #ColorOrder
		for ShiftIndex = 1, ShiftAmount, 1 do
			local FirstColor = table.remove(ColorOrder, 1)
			table.insert(ColorOrder, FirstColor)
		end
	end
	SCOREBOARD_LAST_FIRST_COLOR = ColorOrder[1]
	return ColorOrder
end

local PaintRowText = function (ScoreboardRow)
	local ColorIndex = ScoreboardRow.designColorIndex
	if ColorIndex == nil then
		ColorIndex = 1
	end
	local TextColorR, TextColorG, TextColorB = GetPlayerColor(ColorIndex)
	if ScoreboardRow.playerName ~= nil then
		ScoreboardRow.playerName:setRGB(TextColorR, TextColorG, TextColorB)
	end
	if ScoreboardRow.rankText ~= nil then
		ScoreboardRow.rankText:setRGB(TextColorR, TextColorG, TextColorB)
	end
	if ScoreboardRow.columns ~= nil then
		for ColumnIndex = 1, SCOREBOARD_DEFAULT_MAX_COLUMNS, 1 do
			if ScoreboardRow.columns[ColumnIndex] ~= nil then
				ScoreboardRow.columns[ColumnIndex]:setRGB(TextColorR, TextColorG, TextColorB)
			end
		end
	end
	if ScoreboardRow.pingValue ~= nil then
		ScoreboardRow.pingValue:setRGB(TextColorR, TextColorG, TextColorB)
	end
end

local GetClientColorId = function (ClientNum)
	local NumericClientNum = tonumber(ClientNum)
	if NumericClientNum == nil then
		NumericClientNum = 0
	end

	return (NumericClientNum % 4) + 1
end

local PaintRow = function (ScoreboardRow, ColorIndex)
	if ScoreboardRow == nil then
		return
	end

	if ColorIndex == nil then
		ColorIndex = 1
	end

	ScoreboardRow.designColorIndex = ColorIndex

	if ScoreboardRow.rowBackground ~= nil then
		ScoreboardRow.rowBackground:setImage(RegisterMaterial("t5_scorebar_zom_long_" .. ColorIndex))
	end

	PaintRowText(ScoreboardRow)
end

local SafeText = function (Value)
	if Value == nil then
		return ""
	end
	return tostring(Value)
end

local GetStatMap = function (Controller)
	local ColumnMap = {}

	if Engine == nil or Engine.GetScoreBoardColumnName == nil then
		return ColumnMap
	end

	for ColumnIndex = 0, SCOREBOARD_DEFAULT_MAX_COLUMNS - 1, 1 do
		local RawName = SafeText(Engine.GetScoreBoardColumnName(Controller, ColumnIndex))
		local LocalizedName = RawName

		if Engine.Localize ~= nil then
			LocalizedName = SafeText(Engine.Localize(RawName))
		end

		local CombinedName = string.upper(RawName .. " " .. LocalizedName)

		if ColumnMap.points == nil and (string.find(CombinedName, "POINT") or string.find(CombinedName, "SCORE")) then
			ColumnMap.points = ColumnIndex
		elseif ColumnMap.kills == nil and (string.find(CombinedName, "KILL") or string.find(CombinedName, "ELIM")) then
			ColumnMap.kills = ColumnIndex
		elseif ColumnMap.headshots == nil and string.find(CombinedName, "HEAD") then
			ColumnMap.headshots = ColumnIndex
		elseif ColumnMap.revives == nil and string.find(CombinedName, "REVIV") then
			ColumnMap.revives = ColumnIndex
		elseif ColumnMap.downs == nil and (string.find(CombinedName, "DOWN") or string.find(CombinedName, "RETURN")) then
			ColumnMap.downs = ColumnIndex
		end
	end

	return ColumnMap
end

local GetStatValue = function (Controller, ScoreboardIndex, ColumnInfo, FallbackColumnIndex)
	if ScoreboardIndex == nil then
		return ""
	end

	local ColumnIndex = nil
	local ColumnMap = GetStatMap(Controller)

	if ColumnInfo ~= nil and ColumnInfo.key ~= nil and ColumnMap ~= nil then
		ColumnIndex = ColumnMap[ColumnInfo.key]
	end

	if ColumnIndex == nil and ColumnInfo ~= nil then
		ColumnIndex = ColumnInfo.fallbackColumn
	end

	if ColumnIndex == nil then
		ColumnIndex = FallbackColumnIndex
	end

	if ColumnIndex == nil then
		return ""
	end

	return SafeText(Engine.GetScoreboardColumnForScoreboardIndex(ScoreboardIndex, ColumnIndex))
end

local AddBoardText = function (Parent, Left, Right, Top, Bottom, Text, Alignment)
	local NewText = LUI.UIText.new()
	NewText:setLeftRight(true, false, Left, Right)
	NewText:setTopBottom(true, false, Top, Bottom)
	NewText:setFont(CoD.fonts[SCOREBOARD_FONT])
	NewText:setText(Text)
	NewText:setRGB(1, 1, 1)
	if Alignment ~= nil then
		NewText:setAlignment(Alignment)
	end
	Parent:addElement(NewText)
	return NewText
end

local function AddZmbIcon(parent)
	if parent == nil then
		return nil
	end

	local zmbIcon = LUI.UIImage.new()
	zmbIcon:setLeftRight(false, true, -114, -4)
	zmbIcon:setTopBottom(true, false, 638, 720)
	zmbIcon:setImage(RegisterMaterial("t5_zmb_icon"))
	zmbIcon:setRGB(1, 1, 1)
	zmbIcon:setMouseDisabled(true)
	if zmbIcon.setPriority ~= nil then
		zmbIcon:setPriority(20)
	end
	parent:addElement(zmbIcon)
	return zmbIcon
end

local AddHeaders = function (Parent)
	for ColumnIndex = 1, #SCOREBOARD_COLUMNS, 1 do
		local ColumnInfo = SCOREBOARD_COLUMNS[ColumnIndex]
		AddBoardText(Parent, ColumnInfo.left, ColumnInfo.right, SCOREBOARD_HEADER_TOP, SCOREBOARD_HEADER_BOTTOM, ColumnInfo.header, LUI.Alignment.Center)
	end
	AddBoardText(Parent, SCOREBOARD_PING.left, SCOREBOARD_PING.right, SCOREBOARD_HEADER_TOP, SCOREBOARD_HEADER_BOTTOM, SCOREBOARD_PING.header, LUI.Alignment.Center)
end

CoD.ScoreboardRow = InheritFrom(LUI.UIElement)

local SetOwner = function (ScoreboardWidget, LocalClientIndex)
	ScoreboardWidget.m_ownerController = LocalClientIndex
end

local GetOwner = function (ScoreboardWidget)
	return ScoreboardWidget.m_ownerController
end

local FixZcleansedCol = function (ScoreboardColumnName)
	if Dvar.ui_gametype:get() == CoD.Zombie.GAMETYPE_ZCLEANSED and ScoreboardColumnName == "MPUI_DOWNS" then
		return "MPUI_RETURNS"
	else
		return ScoreboardColumnName
	end
end

local MakeHeaderTitle = function (ScoreboardWidget)
	local HeaderTitle = nil
	if ScoreboardWidget.mode == "theater" then
		HeaderTitle = Engine.Localize("MENU_THEATER_PARTY")
	else
		local Mapname, Gametype = nil, nil
		if ScoreboardWidget.frontEndOnly then
			local AARScoreboardTable = Engine.GetAARScoreboard(ScoreboardWidget.m_ownerController)
			Gametype = AARScoreboardTable.gametype
			Mapname = AARScoreboardTable.mapName
		else
			Gametype = Dvar.ui_gametype:get()
			Mapname = Dvar.ui_mapname:get()
		end
		local StringTable = {}
		if not ScoreboardWidget.frontEndOnly then
			if CoD.isZombie == true then 
				StringTable[1] = CoD.GetZombieGameTypeName(Gametype, Mapname)
				StringTable[2] = " - "
				StringTable[3] = Engine.Localize(UIExpression.TableLookup(nil, CoD.mapsTable, 0, Mapname, 3))
			else
				StringTable[1] = Engine.Localize(UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, Gametype, 7))
				StringTable[2] = " - "
				StringTable[3] = Engine.Localize(UIExpression.TableLookup(nil, CoD.mapsTable, 0, Mapname, 3))
			end
			local RoundLimit = Engine.GetGametypeSetting("roundLimit")
			local RoundPlayed = Engine.GetRoundsPlayed(ScoreboardWidget.m_ownerController)
			if RoundPlayed ~= nil and RoundLimit ~= 1 then
				table.insert(StringTable, " - ")
				if CoD.IsInOvertime(ScoreboardWidget.m_ownerController) then
					table.insert(StringTable, Engine.Localize("MP_OVERTIME"))
				elseif RoundLimit == 0 then
					table.insert(StringTable, Engine.Localize("MPUI_ROUND_X", RoundPlayed + 1))
				else
					table.insert(StringTable, Engine.Localize("MPUI_ROUND_X_OF_Y", RoundPlayed + 1, RoundLimit))
				end
			end
		end
		HeaderTitle = table.concat(StringTable)
	end
	return HeaderTitle
end

function CreateScoreBoardBody(ScoreboardWidget, LocalClientIndex, UnusedArg1)
	ScoreboardWidget.m_ownerController = LocalClientIndex
	ScoreboardWidget.setOwner = SetOwner
	ScoreboardWidget.getOwner = GetOwner
	ScoreboardWidget:setOwner(LocalClientIndex)
	ScoreboardWidget.frontEndOnly = UnusedArg1
	ScoreboardWidget.mode = "game"
	SCOREBOARD_PING_BARS[1] = RegisterMaterial("ping_bar_01")
	SCOREBOARD_PING_BARS[2] = RegisterMaterial("ping_bar_02")
	SCOREBOARD_PING_BARS[3] = RegisterMaterial("ping_bar_03")
	SCOREBOARD_PING_BARS[4] = RegisterMaterial("ping_bar_04")

	ScoreboardWidget.scoreboardContainer = LUI.UIElement.new()
	ScoreboardWidget.scoreboardContainer:setLeftRight(true, true, 0, 0)
	ScoreboardWidget.scoreboardContainer:setTopBottom(true, true, 0, 0)
	ScoreboardWidget:addElement(ScoreboardWidget.scoreboardContainer)
	if not UnusedArg1 then
		ScoreboardWidget.leftButtonPromptBar:close()
		ScoreboardWidget.rightButtonPromptBar:close()
		ScoreboardWidget.scoreboardContainer:addElement(ScoreboardWidget.leftButtonPromptBar)
		ScoreboardWidget.scoreboardContainer:addElement(ScoreboardWidget.rightButtonPromptBar)
	end

	local ScoreboardContainerWidget = LUI.UIElement.new()
	ScoreboardContainerWidget:setLeftRight(true, true, 0, 0)
	ScoreboardContainerWidget:setTopBottom(true, true, 0, 0)
	ScoreboardWidget.scoreboardContainer:addElement(ScoreboardContainerWidget)

	if not UnusedArg1 then
		local ScoreboardGameTimer = CoD.GameTimer.new()
		ScoreboardGameTimer:setLeftRight(true, false, 0, 0)
		ScoreboardGameTimer:setTopBottom(true, false, 0, 0)
		ScoreboardGameTimer:setFont(CoD.fonts[SCOREBOARD_TIMER_FONT])
		ScoreboardGameTimer:setAlpha(0)
		ScoreboardContainerWidget:addElement(ScoreboardGameTimer)
		ScoreboardWidget.gameTimer = ScoreboardGameTimer
	end
	local headerTitle = LUI.UIText.new()
	headerTitle:setLeftRight(true, false, 0, 0)
	headerTitle:setTopBottom(true, false, 0, 0)
	headerTitle:setFont(CoD.fonts.Default)
	headerTitle:setText("")
	headerTitle:setAlpha(0)
	ScoreboardContainerWidget:addElement(headerTitle)
	ScoreboardWidget.headerTitle = headerTitle

	local columnHeaderContainer = LUI.UIContainer.new()
	columnHeaderContainer:setLeftRight(true, true, 0, 0)
	columnHeaderContainer:setTopBottom(true, true, 0, 0)
	ScoreboardContainerWidget:addElement(columnHeaderContainer)
	ScoreboardWidget.columnHeaderContainer = columnHeaderContainer
	AddHeaders(columnHeaderContainer)

	ScoreboardWidget.teamElements = {}
	local ScoreboardTeamCount = Engine.GetGametypeSetting("teamCount")
	if CoD.isZombie and Dvar.ui_gametype:get() == CoD.Zombie.GAMETYPE_ZCLEANSED then
		if ScoreboardTeamCount < 2 then 
			ScoreboardTeamCount = 2
		end
	end
	if UnusedArg1 then
		local AARScoreboardTable = Engine.GetAARScoreboard(LocalClientIndex)
		ScoreboardTeamCount = AARScoreboardTable.teamCount
	end
	for Index = 1, ScoreboardTeamCount, 1 do
		local TeamElement = ScoreboardWidgetCreateTeamElement()
		table.insert(ScoreboardWidget.teamElements, TeamElement)
		ScoreboardWidget.scoreboardContainer:addElement(TeamElement)
	end
	ScoreboardWidget.rows = {}
	ScoreboardWidget.rowColorOrder = MakeColorOrder()
	for ScoreboardRowIndex = 1, SCOREBOARD_MAX_ROWS, 1 do
		local NewRow = CoD.ScoreboardRow.new(LocalClientIndex, ScoreboardRowIndex)
		NewRow.designColorIndex = GetPlayerColorId(ScoreboardRowIndex)
		PaintRow(NewRow, NewRow.designColorIndex)
		ScoreboardWidget.scoreboardContainer:addElement(NewRow)
		table.insert(ScoreboardWidget.rows, NewRow)
	end
	if not ScoreboardWidget.frontEndOnly then
		if UIExpression.IsDemoPlaying(LocalClientIndex) == 1 then
			ScoreboardWidget.spectatePlayerButtonPrompt = CoD.ButtonPrompt.new("primary", "", ScoreboardWidget, "button_prompt_spectate_demo_player")
		else
			ScoreboardWidget.muteButtonPrompt = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_MUTE"), ScoreboardWidget, "button_prompt_toggle_mute")
		end
		if UIExpression.IsDemoPlaying(LocalClientIndex) == 1 then
			ScoreboardWidget.switchScoreboardMode = CoD.ButtonPrompt.new("alt1", "", ScoreboardWidget, "button_prompt_switch_scoreboard_mode", false, nil, nil, nil, "S")
		end
		ScoreboardWidget.showGamerCardButtonPrompt = CoD.ButtonPrompt.new("alt2", Engine.Localize("MENU_LB_VIEW_PLAYER_CARD"), ScoreboardWidget, "button_prompt_show_gamercard", false, nil, nil, nil, "P")
	end
	ScoreboardWidgetUpdateFunc(ScoreboardWidget)
end

local ClientInputSourceChangedCallback = function (ScoreboardWidget, ClientInstance)
	if ScoreboardWidget.spectatePlayerButtonPrompt then
		ScoreboardWidget.spectatePlayerButtonPrompt:processEvent(ClientInstance)
	end
	if ScoreboardWidget.muteButtonPrompt then
		ScoreboardWidget.muteButtonPrompt:processEvent(ClientInstance)
	end
	ScoreboardWidget:dispatchEventToChildren(ClientInstance)
end

LUI.createMenu.Scoreboard = function (LocalClientIndex)
	local BodyVerticalOffset = f0_local41;
	if CoD.isZombie == true then
		IsDLCMap2 = CoD.Zombie.IsDLCMap(CoD.Zombie.DLC2Maps)
		IsDLCMap4 = CoD.Zombie.IsDLCMap(CoD.Zombie.DLC4Maps)
		IsClassic = Dvar.ui_gametype:get() == CoD.Zombie.GAMETYPE_ZCLASSIC
		local CurrentMapName = Dvar.ui_mapname:get()
		if CurrentMapName == "zm_prison" or CurrentMapName == "zm_alcatraz" then
			IsDLCMap2 = true
		end
		if IsDLCMap2 == true then
			require("T6.Zombie.ScoreboardCraftablesZombie")
		end
		if IsDLCMap4 == true then
			require("T6.Zombie.ScoreboardCraftablesTombZombie")
		end
		if (IsDLCMap2 == true or IsDLCMap4 == true) and IsClassic == true then
			BodyVerticalOffset = f0_local41 + 75
		end
	end
	local ScoreboardWidget = CoD.Menu.NewFromState("Scoreboard")
	ScoreboardWidget:setLeftRight(false, false, -640, 640)
	ScoreboardWidget:setTopBottom(false, false, -360, 360)
	ScoreboardWidget:setOwner(LocalClientIndex)
	CreateScoreBoardBody(ScoreboardWidget, LocalClientIndex)

	if CoD.isZombie == true and (IsDLCMap2 == true or IsDLCMap4 == true) then
		local CraftablesAnchor = LUI.UIElement.new()
		CraftablesAnchor:setLeftRight(true, false, SCOREBOARD_ROW_X, SCOREBOARD_ROW_RIGHT)
		CraftablesAnchor:setTopBottom(true, false, SCOREBOARD_HEADER_TOP, SCOREBOARD_HEADER_TOP)
		ScoreboardWidget:addElement(CraftablesAnchor)

		local CraftablesVerticalOffset = f0_local30 + f0_local6
		if IsDLCMap2 == true and CoD.ScoreboardCraftablesZombie ~= nil then
			CoD.ScoreboardCraftablesZombie.new(CraftablesAnchor, CraftablesVerticalOffset)

			ScoreboardWidget.questItemDisplay = CraftablesAnchor.questItemDisplay
			ScoreboardWidget.craftableItemDisplay = CraftablesAnchor.craftableItemDisplay
		elseif IsDLCMap4 == true and IsClassic == true and CoD.ScoreboardCraftablesTombZombie ~= nil then
			CoD.ScoreboardCraftablesTombZombie.new(CraftablesAnchor, CraftablesVerticalOffset)

			ScoreboardWidget.questItemDisplay = CraftablesAnchor.questItemDisplay
			ScoreboardWidget.persistentItemDisplay = CraftablesAnchor.persistentItemDisplay
			ScoreboardWidget.craftableItemDisplay = CraftablesAnchor.craftableItemDisplay
			ScoreboardWidget.captureZoneWheelDisplay = CraftablesAnchor.captureZoneWheelDisplay
		end
	end

	ScoreboardWidget.zmbIcon = AddZmbIcon(ScoreboardWidget)
	ScoreboardWidget.close = ScoreboardWidgetCloseFunc
	ScoreboardWidget:registerEventHandler("close_all_ingame_menus", ScoreboardWidget.close)
	ScoreboardWidget:registerEventHandler("close_scoreboard_menu", ScoreboardWidget.close)
	ScoreboardWidget:registerEventHandler("row_selected", ScoreboardWidgetRowSelectorFunc)
	ScoreboardWidget:registerEventHandler("update_scoreboard", ScoreboardWidgetUpdateFunc)
	ScoreboardWidget:registerEventHandler("button_prompt_show_gamercard", ScoreboardWidgetShowGamercardFunc)
	ScoreboardWidget:registerEventHandler("button_prompt_toggle_mute", ScoreboardWidgetToggleMuteFunc)
	ScoreboardWidget:registerEventHandler("button_prompt_spectate_demo_player", SwitchPlayer)
	ScoreboardWidget:registerEventHandler("button_prompt_switch_scoreboard_mode", SwitchScoreboardMode)
	ScoreboardWidget:registerEventHandler("fullscreen_viewport_start", FullscreenStart)
	ScoreboardWidget:registerEventHandler("fullscreen_viewport_stop", FullscreenStop)
	ScoreboardWidget:registerEventHandler("input_source_changed", ClientInputSourceChangedCallback)

	if CoD.isZombie == true and Dvar.party_maxplayers:get() > 1 then
		CoD.Zombie.SoloQuestMode = false
	end
	return ScoreboardWidget
end

ScoreboardWidgetCloseFunc = function (ScoreboardWidget, UnusedArg1)
	ScoreboardWidget.focusableRowIndex = nil
	ScoreboardWidget.selectedClientNum = nil
	ScoreboardWidget.selectedScoreboardIndex = nil
	CoD.Menu.close(ScoreboardWidget)
end

ScoreboardWidgetCreateTeamElement = function (UnusedArg1)
	local ScoreboardFactionWidget = LUI.UIElement.new()
	ScoreboardFactionWidget:setLeftRight(true, true, 0, 0)
	ScoreboardFactionWidget:setUseStencil(true)
	ScoreboardFactionWidget:setAlpha(0)
	local FactionBackground = LUI.UIImage.new()
	FactionBackground:setLeftRight(true, true, 0, 0)
	FactionBackground:setTopBottom(true, true, 0, 0)
	FactionBackground:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	FactionBackground:setRGB(0, 0, 0)
	FactionBackground:setAlpha(0.5)
	ScoreboardFactionWidget:addElement(FactionBackground)
	ScoreboardFactionWidget.highlightGlow = LUI.UIImage.new()
	ScoreboardFactionWidget.highlightGlow:setLeftRight(true, false, 2, f0_local30 + f0_local24 - 2)
	ScoreboardFactionWidget.highlightGlow:setTopBottom(false, true, -45, -2)
	ScoreboardFactionWidget.highlightGlow:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	ScoreboardFactionWidget.highlightGlow:setAlpha(0.4)
	ScoreboardFactionWidget:addElement(ScoreboardFactionWidget.highlightGlow)
	local f9_local1 = 128
	local f9_local2 = (f0_local30 + f0_local24 - 2) / 2 - f9_local1 / 2
	ScoreboardFactionWidget.factionIcon = LUI.UIImage.new()
	ScoreboardFactionWidget.factionIcon:setLeftRight(true, false, f9_local2, f9_local2 + f9_local1)
	ScoreboardFactionWidget.factionIcon:setTopBottom(false, false, -f9_local1 / 2, f9_local1 / 2)
	ScoreboardFactionWidget.factionIcon:setAlpha(SCOREBOARD_FACTION_ICON_OPACITY)
	ScoreboardFactionWidget:addElement(ScoreboardFactionWidget.factionIcon)
	ScoreboardFactionWidget.background = LUI.UIImage.new()
	ScoreboardFactionWidget.background:setLeftRight(true, true, 0, 0)
	ScoreboardFactionWidget.background:setTopBottom(true, true, 0, 0)
	ScoreboardFactionWidget.background:setRGB(0, 0, 0)
	ScoreboardFactionWidget.background:setAlpha(SCOREBOARD_BACKGROUND_OPACITY)
	ScoreboardFactionWidget:addElement(ScoreboardFactionWidget.background)
	local f9_local4 = LUI.UIImage.new()
	f9_local4:setLeftRight(true, false, 2, f0_local30 + f0_local24 - 2)
	f9_local4:setTopBottom(true, false, 2, 9)
	f9_local4:setImage(RegisterMaterial("white"))
	f9_local4:setAlpha(0.06)
	ScoreboardFactionWidget:addElement(f9_local4)
	local f9_local4 = 5
	ScoreboardFactionWidget.teamScore = LUI.UIText.new()
	ScoreboardFactionWidget.teamScore:setLeftRight(true, false, f9_local4, f9_local4)
	ScoreboardFactionWidget.teamScore:setTopBottom(true, false, -4, CoD.textSize.Big - 4)
	ScoreboardFactionWidget.teamScore:setFont(CoD.fonts.Big)
	ScoreboardFactionWidget.teamScore:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	ScoreboardFactionWidget:addElement(ScoreboardFactionWidget.teamScore)
	local f9_local5 = 38
	ScoreboardFactionWidget.factionName = LUI.UIText.new()
	ScoreboardFactionWidget.factionName:setLeftRight(true, false, f9_local4, f9_local4)
	ScoreboardFactionWidget.factionName:setTopBottom(true, false, f9_local5, f9_local5 + CoD.textSize.ExtraSmall)
	ScoreboardFactionWidget.factionName:setFont(CoD.fonts.ExtraSmall)
	ScoreboardFactionWidget.factionName:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	ScoreboardFactionWidget:addElement(ScoreboardFactionWidget.factionName)
	return ScoreboardFactionWidget
end

ScoreboardWidgetRowSelectorFunc = function (ScoreboardWidget, ScoreboardRowSelected)
	if ScoreboardWidget.frontEndOnly then
		return
	end
	ScoreboardWidget.focusableRowIndex = ScoreboardRowSelected.row.focusableRowIndex
	ScoreboardWidget.selectedClientNum = ScoreboardRowSelected.row.clientNum
	ScoreboardWidget.selectedScoreboardIndex = ScoreboardRowSelected.row.scoreboardIndex
	f0_local38(ScoreboardWidget, Engine.GetClientNum(ScoreboardWidget:getOwner()))
	if ScoreboardWidget.showGamerCardButtonPrompt ~= nil then
		local f10_local2 = ScoreboardRowSelected.row.playerName.gamertag
		local f10_local3 = f10_local2:len()
		if f10_local3 > 3 and f10_local2:sub(f10_local3, f10_local3) == ")" then
			ScoreboardWidget.showGamerCardButtonPrompt:hide()
		else
			ScoreboardWidget.showGamerCardButtonPrompt:show()
		end
	end
end

ScoreboardWidgetShowGamercardFunc = function (ScoreboardWidget, ClientInstance)
	if ScoreboardWidget.frontEndOnly then
		return 
	elseif ScoreboardWidget.selectedClientNum then
		Engine.BlockGameFromKeyEvent()
		CoD.FriendPopup.SelectedPlayerXuid = Engine.GetMatchScoreboardClientXuid(ScoreboardWidget.selectedClientNum)
		CoD.FriendPopup.SelectedPlayerName = Engine.GetFullGamertagForScoreboardIndex(ScoreboardWidget.selectedScoreboardIndex)
		if CoD.FriendPopup.SelectedPlayerXuid and CoD.FriendPopup.SelectedPlayerXuid ~= 0 then
			local GamercardPopup = ScoreboardWidget:openPopup("FriendPopup", ClientInstance.controller)
			GamercardPopup:setClass(CoD.InGameMenu)
			GamercardPopup.isInGameMenu = true
		end
	end
end

ScoreboardWidgetToggleMuteFunc = function (ScoreboardWidget, UnusedArg1)
	if ScoreboardWidget.frontEndOnly then
		return 
	elseif ScoreboardWidget.selectedClientNum then
		Engine.TogglePlayerMute(ScoreboardWidget:getOwner(), ScoreboardWidget.selectedClientNum)
		Engine.BlockGameFromKeyEvent()
		ScoreboardWidgetUpdateFunc(ScoreboardWidget)
	end
end

function SwitchPlayer(ScoreboardWidget, UnusedArg1)
	if ScoreboardWidget.frontEndOnly then
		return 
	elseif ScoreboardWidget.selectedClientNum then
		Engine.Exec(ScoreboardWidget.m_ownerController, "demo_switchplayer 0 " .. ScoreboardWidget.selectedClientNum)
		Engine.BlockGameFromKeyEvent()
		ScoreboardWidgetUpdateFunc(ScoreboardWidget)
	end
end

function SwitchScoreboardMode(ScoreboardWidget, UnusedArg1)
	if ScoreboardWidget.frontEndOnly then
		return 
	elseif ScoreboardWidget.mode == "game" then
		ScoreboardWidget.mode = "theater"
	else
		ScoreboardWidget.mode = "game"
	end
	Engine.BlockGameFromKeyEvent()
	ScoreboardWidgetUpdateFunc(ScoreboardWidget)
end

function FullscreenStart(ScoreboardWidget, ClientInstance)
	ScoreboardWidget.forcedFullscreen = true
	ScoreboardWidget:dispatchEventToChildren(ClientInstance)
end

function FullscreenStop(ScoreboardWidget, ClientInstance)
	ScoreboardWidget.forcedFullscreen = false
	ScoreboardWidget:dispatchEventToChildren(ClientInstance)
end

f0_local38 = function (ScoreboardWidget, ClientNum)
	if ScoreboardWidget.frontEndOnly then
		return
	elseif UIExpression.IsDemoPlaying(ScoreboardWidget.m_ownerController) == 1 then
		if ScoreboardWidget.mode == "theater" then
			ScoreboardWidget.switchScoreboardMode:setText(Engine.Localize("MENU_VIEW_GAME_SCOREBOARD"))
			ScoreboardWidget.spectatePlayerButtonPrompt:close()
		else
			ScoreboardWidget.switchScoreboardMode:setText(Engine.Localize("MENU_VIEW_THEATER_PARTY"))
			if ScoreboardWidget.selectedScoreboardIndex ~= nil then
				ScoreboardWidget.spectatePlayerButtonPrompt:setText(Engine.Localize("MENU_SPECTATE_DEMO_PLAYER", Engine.GetFullGamertagForScoreboardIndex(ScoreboardWidget.selectedScoreboardIndex)))
				if UIExpression.IsDemoClipPlaying() == 0 then
					ScoreboardWidget:addLeftButtonPrompt(ScoreboardWidget.spectatePlayerButtonPrompt)
				end
			end
		end
		ScoreboardWidget:addRightButtonPrompt(ScoreboardWidget.switchScoreboardMode)
	else
		local PlayerMuted = nil
		if ScoreboardWidget.selectedClientNum and ScoreboardWidget.selectedClientNum ~= ClientNum then
			PlayerMuted = Engine.IsPlayerMuteToggled(ScoreboardWidget:getOwner(), ScoreboardWidget.selectedClientNum)
		end
		if PlayerMuted ~= nil and not Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) then
			if PlayerMuted then
				ScoreboardWidget.muteButtonPrompt:setText(Engine.Localize("MENU_UNMUTE"))
			else
				ScoreboardWidget.muteButtonPrompt:setText(Engine.Localize("MENU_MUTE"))
			end
			ScoreboardWidget:addLeftButtonPrompt(ScoreboardWidget.muteButtonPrompt)
		else
			ScoreboardWidget.muteButtonPrompt:close()
		end
		local ShowGamercardButtonPrompt = nil
		if UIExpression.IsGuest(ScoreboardWidget.m_ownerController) ~= 0 or Engine.IsSplitscreen() ~= false or Engine.SessionModeIsMode(CoD.SESSIONMODE_OFFLINE) or Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK) or CoD.isZombie == true and Engine.PartyGetPlayerCount() >= 1 then
			ShowGamercardButtonPrompt = false
		else
			ShowGamercardButtonPrompt = true
		end
		if ShowGamercardButtonPrompt and not CoD.isWIIU and not CoD.isPC then
			ScoreboardWidget:addRightButtonPrompt(ScoreboardWidget.showGamerCardButtonPrompt)
		else
			ScoreboardWidget.showGamerCardButtonPrompt:close()
		end
	end
end

function UpdateGameScoreboard(ScoreboardWidget)
	local ScoreboardTeams = nil
	if CoD.isZombie and Dvar.ui_gametype:get() == CoD.Zombie.GAMETYPE_ZCLEANSED then
		ScoreboardTeams = Engine.GetTeamPositions(ScoreboardWidget:getOwner(), 2)
	else
		ScoreboardTeams = Engine.GetTeamPositions(ScoreboardWidget:getOwner())
	end
	if ScoreboardWidget.frontEndOnly then
		local AARScoreboardTable = Engine.GetAARScoreboard(ScoreboardWidget:getOwner())
		ScoreboardTeams = Engine.GetTeamPositions(ScoreboardWidget:getOwner(), AARScoreboardTable.teamCount)
	end
	local TeamElementIndex = 1
	local ScoreboardRowIndex = 1
	local f18_local5 = SCOREBOARD_ROW_START_Y
	if not ScoreboardWidget.frontEndOnly and ScoreboardWidget.gameTimer ~= nil then
		ScoreboardWidget.gameTimer:setAlpha(0)
	end
	ScoreboardWidget.headerTitle:setText("")
	ScoreboardWidget.headerTitle:setAlpha(0)
	ScoreboardWidget.columnHeaderContainer:setAlpha(1)
	local GreatestNumberOfClientsOnATeam = 0
	for Key, ScoreboardTeam in ipairs(ScoreboardTeams) do
		ScoreboardTeam.numClients = Engine.GetMatchScoreboardClientCount(ScoreboardTeam.team)
		if GreatestNumberOfClientsOnATeam < ScoreboardTeam.numClients then
			GreatestNumberOfClientsOnATeam = ScoreboardTeam.numClients
		end
	end
	local MinRowsPerTeam = CoD.MPZM(2, 4)
	if GreatestNumberOfClientsOnATeam <= math.floor(SCOREBOARD_MAX_ROWS / #ScoreboardTeams) then
		MinRowsPerTeam = math.max(MinRowsPerTeam, GreatestNumberOfClientsOnATeam)
	end
	if CoD.isZombie and Engine.GetGametypeSetting("teamCount") > 2 then
		MinRowsPerTeam = 2
	end
	local ClientNum = nil
	if not ScoreboardWidget.frontEndOnly then
		ClientNum = Engine.GetClientNum(ScoreboardWidget:getOwner())
	end
	local f18_local12, f18_local13, f18_local14, f18_local15 = nil, nil, nil, nil
	local FocusableRowIndex = 1
	for Key, ScoreboardTeam in ipairs(ScoreboardTeams) do
		if ScoreboardWidget.teamElements[TeamElementIndex] and ScoreboardTeam.numClients > 0 then
			local FactionTeam = nil
			FactionTeam = Engine.GetFactionForTeam(ScoreboardTeam.team)
			if ScoreboardWidget.frontEndOnly then
				local AARScoreboardTable = Engine.GetAARScoreboard(ScoreboardWidget:getOwner())
				FactionTeam = Engine.GetFactionForTeam(ScoreboardTeam.team, AARScoreboardTable.mapName)
			end
			if FactionTeam then
				local FactionColorR, FactionColorG, FactionColorB = Engine.GetFactionColor(FactionTeam)
				if ScoreboardTeam.team == CoD.TEAM_FREE then
					FactionColorR = CoD.offWhite.r
					FactionColorG = CoD.offWhite.g
					FactionColorB = CoD.offWhite.b
				end
				if CoD.isZombie == true then
					local GamemodeGroup = UIExpression.DvarString(nil, "ui_zm_gamemodegroup")
					if GamemodeGroup == CoD.Zombie.GAMETYPEGROUP_ZCLASSIC then
						FactionColorR = CoD.Zombie.SingleTeamColor.r
						FactionColorG = CoD.Zombie.SingleTeamColor.g
						FactionColorB = CoD.Zombie.SingleTeamColor.b
					elseif GamemodeGroup == CoD.Zombie.GAMETYPEGROUP_ZSURVIVAL then
						if CoD.Zombie.IsSurvivalUsingCIAModel == true then
							FactionColorR, FactionColorG, FactionColorB = Engine.GetFactionColor("cia")
						end
					end
				end
				ScoreboardUpdateTeamElement(ScoreboardWidget.teamElements[TeamElementIndex], FactionTeam, FactionColorR, FactionColorG, FactionColorB, ScoreboardTeam, math.max(MinRowsPerTeam, ScoreboardTeam.numClients), f18_local5)
				TeamElementIndex = TeamElementIndex + 1
				for PlayerIndex = 0, ScoreboardTeam.numClients - 1, 1 do
					local ScoreboardRow = ScoreboardWidget.rows[ScoreboardRowIndex]
					f18_local5 = ScoreboardRow:setClient(FactionColorR, FactionColorG, FactionColorB, f18_local5, ScoreboardWidget.mode, ClientNum, FocusableRowIndex, PlayerIndex, ScoreboardTeam, ScoreboardWidget.frontEndOnly)
					if ScoreboardRow.clientNum == ClientNum then
						f18_local15 = ScoreboardRow
					end
					if not ScoreboardWidget.frontEndOnly then
						if FocusableRowIndex == ScoreboardWidget.focusableRowIndex then
							ScoreboardRow:processEvent(LUI.UIButton.GainFocusEvent)
							f18_local14 = ScoreboardRow
						elseif (f18_local15 ~= ScoreboardRow or ScoreboardWidget.focusableRowIndex) and ScoreboardRow:isInFocus() then
							ScoreboardRow:processEvent(LUI.UIButton.LoseFocusEvent)
						end
					end
					ScoreboardRow.navigation.up = f18_local13
					if f18_local13 then
						f18_local13.navigation.down = ScoreboardRow
					end
					f18_local13 = ScoreboardRow
					if not f18_local12 then
						f18_local12 = ScoreboardRow
					end
					ScoreboardRowIndex = ScoreboardRowIndex + 1
					FocusableRowIndex = FocusableRowIndex + 1
				end
				for PlayerIndex = ScoreboardTeam.numClients + 1, MinRowsPerTeam, 1 do
					local ScoreboardRow = ScoreboardWidget.rows[ScoreboardRowIndex]
					if ScoreboardRow:isInFocus() and not ScoreboardWidget.frontEndOnly then
						ScoreboardRow:processEvent(LUI.UIButton.LoseFocusEvent)
					end
					f18_local5 = ScoreboardRow:setClient(FactionColorR, FactionColorG, FactionColorB, f18_local5, ScoreboardWidget.mode)
					ScoreboardRowIndex = ScoreboardRowIndex + 1
				end
				f18_local5 = f18_local5 + f0_local32
			end
		end
	end
	if f18_local12 then
		if f18_local12 ~= f18_local13 then
			f18_local12.navigation.up = f18_local13
			f18_local13.navigation.down = f18_local12
		else
			f18_local13.navigation.up = nil
			f18_local13.navigation.down = nil
		end
	end
	if not f18_local14 and f18_local15 and not ScoreboardWidget.frontEndOnly then 
		f18_local15:processEvent(LUI.UIButton.GainFocusEvent)
		while TeamElementIndex <= #ScoreboardWidget.teamElements do
			ScoreboardWidget.teamElements[TeamElementIndex]:setAlpha(0)
			TeamElementIndex = TeamElementIndex + 1
		end
		ScoreboardWidget:setLeftRight(false, false, -640, 640)
		ScoreboardWidget:setTopBottom(false, false, -360, 360)
		while ScoreboardRowIndex <= #ScoreboardWidget.rows do
			ScoreboardWidget.rows[ScoreboardRowIndex]:setAlpha(0)
			ScoreboardRowIndex = ScoreboardRowIndex + 1
		end
		if not ScoreboardWidget.frontEndOnly then
			ScoreboardWidget.leftButtonPromptBar:setTopBottom(true, false, f18_local5, f18_local5 + CoD.ButtonPrompt.Height)
			ScoreboardWidget.rightButtonPromptBar:setTopBottom(true, false, f18_local5, f18_local5 + CoD.ButtonPrompt.Height)
		end
	end
end

function UpdateTheaterScoreboard(ScoreboardWidget)
	local TeamElementIndex = 1
	local ScoreboardRowIndex = 1
	local f19_local4 = SCOREBOARD_ROW_START_Y
	if not ScoreboardWidget.frontEndOnly then
		ScoreboardWidget.gameTimer:setAlpha(0)
	end
	ScoreboardWidget.headerTitle:setText("")
	ScoreboardWidget.headerTitle:setAlpha(0)
	ScoreboardWidget.columnHeaderContainer:setAlpha(1)
	local PlayerCount = Engine.PartyGetPlayerCount()
	local f19_local10 = math.max(CoD.MPZM(2, 4), PlayerCount)
	local f19_local11, f19_local12, f19_local13, f19_local14 = nil, nil, nil, nil
	local FocusableRowIndex = 1
	if ScoreboardWidget.focusableRowIndex == nil then
		ScoreboardWidget.focusableRowIndex = FocusableRowIndex
	end
	if PlayerCount < ScoreboardWidget.focusableRowIndex then
		ScoreboardWidget.focusableRowIndex = PlayerCount
	end
	local PlayersInLobby = Engine.GetPlayersInLobby()
	ScoreboardUpdateTeamElement(ScoreboardWidget.teamElements[TeamElementIndex], PlayersInLobby[ScoreboardWidget.focusableRowIndex].xuid, CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, nil, math.max(f19_local10, PlayerCount), f19_local4)
	TeamElementIndex = TeamElementIndex + 1
	for PlayerIndex = 0, PlayerCount - 1, 1 do
		local ScoreboardRow = ScoreboardWidget.rows[ScoreboardRowIndex]
		f19_local4 = ScoreboardRow:setClient(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, f19_local4, ScoreboardWidget.mode, nil, FocusableRowIndex, PlayerIndex, nil, ScoreboardWidget.frontEndOnly)
		if ScoreboardRowIndex == 1 then
			f19_local14 = ScoreboardRow[ScoreboardRowIndex]
		end
		if not ScoreboardWidget.frontEndOnly then
			if FocusableRowIndex == ScoreboardWidget.focusableRowIndex then
				ScoreboardRow:processEvent(LUI.UIButton.GainFocusEvent)
				f19_local13 = ScoreboardRow
			elseif (f19_local14 ~= ScoreboardRow or ScoreboardWidget.focusableRowIndex) and ScoreboardRow:isInFocus() then
				ScoreboardRow:processEvent(LUI.UIButton.LoseFocusEvent)
			end
		end
		ScoreboardRow.navigation.up = f19_local12
		if f19_local12 then
			f19_local12.navigation.down = ScoreboardRow
		end
		f19_local12 = ScoreboardRow
		if not f19_local11 then
			f19_local11 = ScoreboardRow
		end
		ScoreboardRowIndex = ScoreboardRowIndex + 1
		FocusableRowIndex = FocusableRowIndex + 1
	end
	for PlayerIndex = PlayerCount + 1, f19_local10, 1 do
		local ScoreboardRow = ScoreboardWidget.rows[ScoreboardRowIndex]
		if ScoreboardRow:isInFocus() and not ScoreboardWidget.frontEndOnly then
			ScoreboardRow:processEvent(LUI.UIButton.LoseFocusEvent)
		end
		f19_local4 = ScoreboardRow:setClient(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, f19_local4, ScoreboardWidget.mode)
		ScoreboardRowIndex = ScoreboardRowIndex + 1
	end
	if f19_local11 then
		if f19_local11 ~= f19_local12 then
			f19_local11.navigation.up = f19_local12
			f19_local12.navigation.down = f19_local11
		else
			f19_local12.navigation.up = nil
			f19_local12.navigation.down = nil
		end
	end
	if not f19_local13 and f19_local14 and not ScoreboardWidget.frontEndOnly then
		f19_local14:processEvent(LUI.UIButton.GainFocusEvent)
		while TeamElementIndex <= #ScoreboardWidget.teamElements do
			ScoreboardWidget.teamElements[TeamElementIndex]:setAlpha(0)
			TeamElementIndex = TeamElementIndex + 1
		end
		ScoreboardWidget:setLeftRight(false, false, -640, 640)
		ScoreboardWidget:setTopBottom(false, false, -360, 360)
		while ScoreboardRowIndex <= #ScoreboardWidget.rows do
			ScoreboardWidget.rows[ScoreboardRowIndex]:setAlpha(0)
			ScoreboardRowIndex = ScoreboardRowIndex + 1
		end
		if not ScoreboardWidget.frontEndOnly then
			ScoreboardWidget.leftButtonPromptBar:setTopBottom(true, false, f19_local4, f19_local4 + CoD.ButtonPrompt.Height)
			ScoreboardWidget.rightButtonPromptBar:setTopBottom(true, false, f19_local4, f19_local4 + CoD.ButtonPrompt.Height)
		end
	end
end

ScoreboardWidgetUpdateFunc = function (ScoreboardWidget)
	if ScoreboardWidget.mode == "theater" and not ScoreboardWidget.frontEndOnly then
		UpdateTheaterScoreboard(ScoreboardWidget)
	else
		UpdateGameScoreboard(ScoreboardWidget)
	end
end

ScoreboardUpdateTeamElement = function (TeamElement, FactionTeam, FactionColorR, FactionColorG, FactionColorB, ScoreboardTeam, MinRowsPerTeam, f21_arg7)
	local VerticalOffset = MinRowsPerTeam * (SCOREBOARD_ROW_HEIGHT + SCOREBOARD_ROW_GAP)
	TeamElement:setTopBottom(true, false, f21_arg7, f21_arg7 + VerticalOffset)
	TeamElement:setAlpha(0)
end

CoD.ScoreboardRow.GetRowTextColor = function (ScoreboardRowIndex)
	local ColorIndex = (ScoreboardRowIndex - 1) % 4 + 1
	return GetPlayerColor(ColorIndex)
end

CoD.ScoreboardRow.new = function (LocalClientIndex, ScoreboardRowIndex)
	local RowTextColorR, RowTextColorG, RowTextColorB = CoD.ScoreboardRow.GetRowTextColor(ScoreboardRowIndex)
	local ScoreboardRowWidget = LUI.UIElement.new()
	ScoreboardRowWidget:setClass(CoD.ScoreboardRow)
	ScoreboardRowWidget.ownerController = LocalClientIndex
	ScoreboardRowWidget:makeFocusable()
	ScoreboardRowWidget:setLeftRight(true, false, 0, 1280)
	ScoreboardRowWidget:setAlpha(0)

	local RowMaterialIndex = GetPlayerColorId(ScoreboardRowIndex)
	ScoreboardRowWidget.rowBackground = LUI.UIImage.new()
	ScoreboardRowWidget.rowBackground:setLeftRight(true, false, SCOREBOARD_ROW_X, SCOREBOARD_ROW_RIGHT)
	ScoreboardRowWidget.rowBackground:setTopBottom(true, false, 0, SCOREBOARD_ROW_HEIGHT)
	ScoreboardRowWidget.rowBackground:setImage(RegisterMaterial("t5_scorebar_zom_long_" .. RowMaterialIndex))
	ScoreboardRowWidget.rowBackground:setRGB(SCOREBOARD_ROW_NORMAL_R, SCOREBOARD_ROW_NORMAL_G, SCOREBOARD_ROW_NORMAL_B)
	ScoreboardRowWidget.rowBackground:setAlpha(SCOREBOARD_ROW_ALPHA)
	ScoreboardRowWidget:addElement(ScoreboardRowWidget.rowBackground)

	ScoreboardRowWidget.statusIcon = LUI.UIImage.new()
	ScoreboardRowWidget.statusIcon:setAlpha(0)
	ScoreboardRowWidget:addElement(ScoreboardRowWidget.statusIcon)
	ScoreboardRowWidget.voipIcon = LUI.UIImage.new()
	ScoreboardRowWidget.voipIcon:setAlpha(0)
	ScoreboardRowWidget:addElement(ScoreboardRowWidget.voipIcon)
	if not CoD.isZombie then
		ScoreboardRowWidget.rankText = LUI.UIText.new()
		ScoreboardRowWidget.rankText:setAlpha(0)
		ScoreboardRowWidget:addElement(ScoreboardRowWidget.rankText)
	end
	ScoreboardRowWidget.rankIcon = LUI.UIImage.new()
	ScoreboardRowWidget.rankIcon:setAlpha(0)
	ScoreboardRowWidget:addElement(ScoreboardRowWidget.rankIcon)

	ScoreboardRowWidget.playerName = LUI.UIText.new()
	ScoreboardRowWidget.playerName:setLeftRight(true, false, SCOREBOARD_NAME_LEFT, SCOREBOARD_NAME_RIGHT)
	ScoreboardRowWidget.playerName:setTopBottom(true, false, SCOREBOARD_NAME_TOP, SCOREBOARD_NAME_BOTTOM)
	ScoreboardRowWidget.playerName:setFont(CoD.fonts[SCOREBOARD_FONT])
	ScoreboardRowWidget.playerName:setScale(SCOREBOARD_NAME_SCALE)
	ScoreboardRowWidget.playerName:setRGB(RowTextColorR, RowTextColorG, RowTextColorB)
	ScoreboardRowWidget:addElement(ScoreboardRowWidget.playerName)

	ScoreboardRowWidget.columnBackgrounds = {}
	ScoreboardRowWidget.columns = {}
	for ColumnIndex = 1, SCOREBOARD_DEFAULT_MAX_COLUMNS, 1 do
		local ColumnInfo = SCOREBOARD_COLUMNS[ColumnIndex]
		if ColumnInfo ~= nil then
			local ColumnText = LUI.UIText.new()
			ColumnText:setLeftRight(true, false, ColumnInfo.left, ColumnInfo.right)
			ColumnText:setTopBottom(true, false, SCOREBOARD_ROW_TEXT_TOP, SCOREBOARD_ROW_TEXT_BOTTOM)
			ColumnText:setFont(CoD.fonts[SCOREBOARD_FONT])
			ColumnText:setAlignment(LUI.Alignment.Center)
			ColumnText:setRGB(RowTextColorR, RowTextColorG, RowTextColorB)
			ScoreboardRowWidget:addElement(ColumnText)
			ScoreboardRowWidget.columns[ColumnIndex] = ColumnText
		end
	end

	ScoreboardRowWidget.pingValue = LUI.UIText.new()
	ScoreboardRowWidget.pingValue:setLeftRight(true, false, SCOREBOARD_PING.left, SCOREBOARD_PING.right)
	ScoreboardRowWidget.pingValue:setTopBottom(true, false, SCOREBOARD_ROW_TEXT_TOP, SCOREBOARD_ROW_TEXT_BOTTOM)
	ScoreboardRowWidget.pingValue:setFont(CoD.fonts[SCOREBOARD_FONT])
	ScoreboardRowWidget.pingValue:setAlignment(LUI.Alignment.Center)
	ScoreboardRowWidget.pingValue:setRGB(RowTextColorR, RowTextColorG, RowTextColorB)
	ScoreboardRowWidget:addElement(ScoreboardRowWidget.pingValue)

	ScoreboardRowWidget.border = CoD.Border.new(1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b, 1, -1)
	ScoreboardRowWidget.border:setLeftRight(true, false, SCOREBOARD_ROW_X, SCOREBOARD_ROW_RIGHT)
	ScoreboardRowWidget.border:setTopBottom(true, false, 0, SCOREBOARD_ROW_HEIGHT)
	ScoreboardRowWidget.border:setAlpha(0)
	ScoreboardRowWidget:addElement(ScoreboardRowWidget.border)
	return ScoreboardRowWidget
end

CoD.ScoreboardRow.setClient = function (ScoreboardRow, FactionColorR, FactionColorG, FactionColorB, VerticalOffset, ScoreboardMode, ClientNum, FocusableRowIndex, PlayerIndex, ScoreboardTeam, ScoreboardFrontEndOnly)
	local IsTheaterMode = ScoreboardMode == "theater"
	local PlayerRank, PlayerRankIcon, PlayerPrestige, PlayerGamerTag, PlayerScoreboardIndex, PlayerScoreboardClientNum = nil, nil, nil, nil, nil, nil
	local MaxColumns = SCOREBOARD_DEFAULT_MAX_COLUMNS
	local OriginalVerticalOffset = VerticalOffset
	ScoreboardRow:beginAnimation("move_row")
	ScoreboardRow:setTopBottom(true, false, VerticalOffset, VerticalOffset + SCOREBOARD_ROW_HEIGHT)
	ScoreboardRow:setAlpha(1)
	VerticalOffset = VerticalOffset + SCOREBOARD_ROW_HEIGHT + SCOREBOARD_ROW_GAP
	if IsTheaterMode then
		for Key, ColumnBackgrounds in ipairs(ScoreboardRow.columnBackgrounds) do
			ColumnBackgrounds:setAlpha(0)
		end
	else
		for Key, ColumnBackgrounds in ipairs(ScoreboardRow.columnBackgrounds) do
			ColumnBackgrounds:setRGB(FactionColorR, FactionColorG, FactionColorB)
			ColumnBackgrounds:setAlpha(SCOREBOARD_COLUMN_BACKGROUND_OPACITY)
		end
	end
	if PlayerIndex then
		if IsTheaterMode then
			local PlayersInLobby = Engine.GetPlayersInLobby()
			ScoreboardRow.clientNum = nil
			ScoreboardRow.scoreboardIndex = nil
			PlayerRank = PlayersInLobby[FocusableRowIndex].rank
			PlayerPrestige = PlayersInLobby[FocusableRowIndex].prestige
			PlayerRankIcon = PlayersInLobby[FocusableRowIndex].rankIcon
			PlayerGamerTag = PlayersInLobby[FocusableRowIndex].clean_gamertag
			if PlayersInLobby[FocusableRowIndex].clantag ~= "" then
				PlayerGamerTag = CoD.getClanTag(PlayersInLobby[FocusableRowIndex].clantag) .. PlayerGamerTag
			end
			PaintRow(ScoreboardRow, GetPlayerColorId(FocusableRowIndex))
		else
			local SortType = CoD.MPZM(CoD.SCOREBOARD_SORT_DEFAULT, CoD.SCOREBOARD_SORT_CLIENTNUM)
			if CoD.isZombie and Dvar.ui_gametype:get() == CoD.Zombie.GAMETYPE_ZCLEANSED then
				SortType = CoD.SCOREBOARD_SORT_DEFAULT
			end
			PlayerScoreboardIndex, PlayerScoreboardClientNum = Engine.GetMatchScoreboardIndexAndClientNumForTeam(PlayerIndex, ScoreboardTeam.team, SortType)
			ScoreboardRow.clientNum = PlayerScoreboardClientNum
			ScoreboardRow.scoreboardIndex = PlayerScoreboardIndex
			if CoD.isOnlineGame() then
				PlayerRank = Engine.GetRankForScoreboardIndex(PlayerScoreboardIndex)
				PlayerRankIcon = Engine.GetRankIconForScoreboardIndex(PlayerScoreboardIndex)
				PlayerPrestige = Engine.GetPrestigeForScoreboardIndex(PlayerScoreboardIndex)
			end
			PlayerGamerTag = Engine.GetFullGamertagForScoreboardIndex(PlayerScoreboardIndex)
			PaintRow(ScoreboardRow, GetPlayerColorId(FocusableRowIndex))
		end
		ScoreboardRow.focusableRowIndex = FocusableRowIndex
		if PlayerScoreboardClientNum ~= nil and not ScoreboardFrontEndOnly and not IsTheaterMode then
			local ClientStatusIcon = Engine.GetStatusIconForClient(PlayerScoreboardClientNum)
			ScoreboardRow.statusIcon:setAlpha(0)
		else
			ScoreboardRow.statusIcon:setAlpha(0)
		end
		if ScoreboardRow.rankText ~= nil then
			if PlayerPrestige and PlayerPrestige == tonumber(CoD.MAX_PRESTIGE) then
				ScoreboardRow.rankText:setText("")
			elseif PlayerRank and ScoreboardRow.rankText ~= nil then
				ScoreboardRow.rankText:setText(PlayerRank)
			end
		end
		if ScoreboardRow.rankIcon ~= nil then
			ScoreboardRow.rankIcon:setAlpha(0)
		end
		ScoreboardRow.playerName:setText(PlayerGamerTag)
		ScoreboardRow.playerName:setAlpha(1)
		ScoreboardRow.playerName.gamertag = PlayerGamerTag
		PaintRowText(ScoreboardRow)
		if PlayerScoreboardClientNum ~= nil and not IsTheaterMode then
			if ScoreboardRow.voipIcon ~= nil then
				ScoreboardRow.voipIcon:setAlpha(0)
			end
			for ColumnIndex = 1, MaxColumns, 1 do
				if ScoreboardRow.columns[ColumnIndex] then
					ScoreboardRow.columns[ColumnIndex]:setText(SafeText(Engine.GetScoreboardColumnForScoreboardIndex(PlayerScoreboardIndex, ColumnIndex - 1)))
					ScoreboardRow.columns[ColumnIndex]:setAlpha(1)
				end
			end
			if ScoreboardRow.pingBars ~= nil then
				if not ScoreboardFrontEndOnly then
					ScoreboardRow.pingBars:setImage(SCOREBOARD_PING_BARS[math.max(1, #SCOREBOARD_PING_BARS - math.floor(Engine.GetPingForScoreboardIndex(PlayerScoreboardIndex) / 100))])
					ScoreboardRow.pingBars:setAlpha(1)
				else
					ScoreboardRow.pingBars:setAlpha(0)
				end
			end
			if ScoreboardRow.pingValue ~= nil then
				if not ScoreboardFrontEndOnly then
					local PingValue = Engine.GetPingForScoreboardIndex(PlayerScoreboardIndex)
					if UIExpression.IsDemoPlaying(PlayerIndex) == 1 then
						if PingValue == 0 then
							PingValue = 50
						elseif PingValue == 1 then
							PingValue = 100
						elseif PingValue == 2 then
							PingValue = 200
						elseif PingValue == 3 then
							PingValue = 300
						elseif PingValue < 7 then
							PingValue = 500
						elseif PingValue < 10 then
							PingValue = 999
						end
					end
					ScoreboardRow.pingValue:setText(PingValue)
					ScoreboardRow.pingValue:setAlpha(1)
				end
			else
				ScoreboardRow.pingValue:setAlpha(0)
			end
			PaintRowText(ScoreboardRow)
		else
			if ScoreboardRow.voipIcon ~= nil then
				ScoreboardRow.voipIcon:close()
			end
			for ColumnIndex = 1, MaxColumns, 1 do
				if ScoreboardRow.columns[ColumnIndex] then
					ScoreboardRow.columns[ColumnIndex]:setText("")
				end
			end
			if ScoreboardRow.pingBars ~= nil then
				ScoreboardRow.pingBars:setAlpha(0)
			end
			if ScoreboardRow.pingValue ~= nil then
				ScoreboardRow.pingValue:setAlpha(0)
			end
		end
	else

		ScoreboardRow:setAlpha(0)
		ScoreboardRow.clientNum = nil
		ScoreboardRow.focusableRowIndex = nil
		ScoreboardRow.scoreboardIndex = nil
		ScoreboardRow.statusIcon:setAlpha(0)
		if ScoreboardRow.rankText ~= nil then
			ScoreboardRow.rankText:setText("")
			ScoreboardRow.rankText:setAlpha(0)
		end
		if ScoreboardRow.rankIcon ~= nil then
			ScoreboardRow.rankIcon:setAlpha(0)
		end
		if ScoreboardRow.playerName ~= nil then
			ScoreboardRow.playerName:setText("")
		end
		if ScoreboardRow.voipIcon ~= nil then
			ScoreboardRow.voipIcon:setAlpha(0)
		end
		for ColumnIndex = 1, MaxColumns, 1 do
			if ScoreboardRow.columns[ColumnIndex] then
				ScoreboardRow.columns[ColumnIndex]:setText("")
				ScoreboardRow.columns[ColumnIndex]:setAlpha(0)
			end
		end
		if ScoreboardRow.pingBars ~= nil then
			ScoreboardRow.pingBars:setAlpha(0)
		end
		if ScoreboardRow.pingValue ~= nil then
			ScoreboardRow.pingValue:setText("")
			ScoreboardRow.pingValue:setAlpha(0)
		end
		return OriginalVerticalOffset
	end
	return VerticalOffset
end

CoD.ScoreboardRow.gainFocus = function (Button, EventGainFocus)
	CoD.ScoreboardRow.super.gainFocus(Button, EventGainFocus)
	if Button.rowBackground ~= nil then
		Button.rowBackground:setRGB(SCOREBOARD_ROW_FOCUSED_R, SCOREBOARD_ROW_FOCUSED_G, SCOREBOARD_ROW_FOCUSED_B)
		Button.rowBackground:setAlpha(SCOREBOARD_ROW_ALPHA)
	end
	if Button.border ~= nil then
		Button.border:setAlpha(0)
	end
	Button:dispatchEventToChildren(EventGainFocus)
	SCOREBOARD_ROW_SELECTED.row = Button
	Button:dispatchEventToParent(SCOREBOARD_ROW_SELECTED)
end

CoD.ScoreboardRow.loseFocus = function (Button, EventLoseFocus)
	CoD.ScoreboardRow.super.loseFocus(Button, EventLoseFocus)
	if Button.rowBackground ~= nil then
		Button.rowBackground:setRGB(SCOREBOARD_ROW_NORMAL_R, SCOREBOARD_ROW_NORMAL_G, SCOREBOARD_ROW_NORMAL_B)
		Button.rowBackground:setAlpha(SCOREBOARD_ROW_ALPHA)
	end
	if Button.border ~= nil then
		Button.border:setAlpha(0)
	end
	Button:dispatchEventToChildren(EventLoseFocus)
end

CoD.ScoreboardRow.focusClient = function (ScoreboardWidget, EventFocusClient)
	if ScoreboardWidget.clientNum == EventFocusClient.clientNum then
		ScoreboardWidget:processEvent(LUI.UIButton.GainFocusEvent)
	elseif ScoreboardWidget:isInFocus() then
		ScoreboardWidget:processEvent(LUI.UIButton.LoseFocusEvent)
	end
end

CoD.ScoreboardRow:registerEventHandler("gain_focus", CoD.ScoreboardRow.gainFocus)
CoD.ScoreboardRow:registerEventHandler("lose_focus", CoD.ScoreboardRow.loseFocus)
CoD.ScoreboardRow:registerEventHandler("focus_client", CoD.ScoreboardRow.focusClient)