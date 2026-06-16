CoD.T5AmmoCounter = {}
CoD.T5AmmoCounter.LowAmmoFadeTime = 500
CoD.T5AmmoCounter.AutoHideDelay = 5000
CoD.T5AmmoCounter.AutoHideFadeTime = 500
CoD.T5AmmoCounter.TextFontName = "Morris"

local T5_HUD_WIDTH = 1280
local T5_HUD_HEIGHT = 720

local function SetT5RightBottomBounds(element, left, right, top, bottom)
	element:setLeftRight(false, true, left - T5_HUD_WIDTH, right - T5_HUD_WIDTH)
	element:setTopBottom(false, true, top - T5_HUD_HEIGHT, bottom - T5_HUD_HEIGHT)
end

local function SetTextSafe(textElement, value, localize)
	if value == nil then
		return
	end
	if localize == true then
		textElement:setText(Engine.Localize(value))
	else
		textElement:setText(tostring(value))
	end
end

local function AddImage(parent, materialName, left, right, top, bottom, opts)
	local image = LUI.UIImage.new()
	SetT5RightBottomBounds(image, left, right, top, bottom)
	image:setImage(RegisterMaterial(materialName))
	image:setRGB(1, 1, 1)

	if opts ~= nil then
		if opts.rgb ~= nil then
			image:setRGB(opts.rgb[1], opts.rgb[2], opts.rgb[3])
		end
		if opts.alpha ~= nil and image.setAlpha ~= nil then
			image:setAlpha(opts.alpha)
		end
		if opts.scale ~= nil and image.setScale ~= nil then
			image:setScale(opts.scale)
		end
		if opts.zRot ~= nil and image.setZRot ~= nil then
			image:setZRot(opts.zRot)
		end
	end

	parent:addElement(image)
	return image
end

local function AddText(parent, left, right, top, bottom, defaultText, scale, alignment)
	local text = LUI.UIText.new()
	text:setLeftRight(true, false, left, right)
	text:setTopBottom(true, false, top, bottom)
	text:setText(defaultText)
	text:setFont(CoD.fonts.Default)
	text:setRGB(1, 1, 1)
	text:setScale(scale or 1)
	text:setAlignment(alignment or LUI.Alignment.Center)
	parent:addElement(text)
	return text
end

local function GetT5AmmoTextFont()
	if CoD ~= nil and CoD.fonts ~= nil and CoD.fonts[CoD.T5AmmoCounter.TextFontName] ~= nil then
		return CoD.fonts[CoD.T5AmmoCounter.TextFontName]
	end

	return CoD.fonts.Default
end

local function AddT5Text(parent, leftAnchor, rightAnchor, left, right, topAnchor, bottomAnchor, top, bottom, defaultText, scale, alignment, rgb)
	local text = LUI.UIText.new()
	text:setLeftRight(leftAnchor, rightAnchor, left, right)
	text:setTopBottom(topAnchor, bottomAnchor, top, bottom)
	text:setText(defaultText or "")
	text:setFont(GetT5AmmoTextFont())
	text:setRGB(1, 1, 1)
	if rgb ~= nil then
		text:setRGB(rgb[1], rgb[2], rgb[3])
	end
	text:setScale(scale or 0.5)
	text:setAlignment(alignment or LUI.Alignment.Right)
	parent:addElement(text)
	return text
end

local function AddT5SlotLabel(parent, id, left, right, top, bottom, labelText)
	local text = LUI.UIText.new()
	text.id = id
	SetT5RightBottomBounds(text, left, right, top, bottom)
	text:setText(Engine.Localize(labelText))
	text:setFont(CoD.fonts.Default)
	text:setRGB(1, 1, 1)
	text:setScale(0.54)
	text:setAlignment(LUI.Alignment.Center)
	parent:addElement(text)
	return text
end

local function GetT5ActionSlotKeybindText(controller, slotIndex)
	local command = "+actionslot " .. tostring(slotIndex)

	if Engine ~= nil and Engine.GetKeyBindingLocalizedString ~= nil then
		local keyText = Engine.GetKeyBindingLocalizedString(controller or 0, command, 0)
		if keyText ~= nil and keyText ~= "" then
			return "[" .. tostring(keyText) .. "]"
		end
	end

	if UIExpression ~= nil and UIExpression.KeyBinding ~= nil then
		local keyText = UIExpression.KeyBinding(controller or 0, command)
		if keyText ~= nil and keyText ~= "" then
			return "[" .. tostring(keyText) .. "]"
		end
	end

	return "[" .. tostring(slotIndex) .. "]"
end

local function UpdateT5ActionSlotKeybindLabels(menu, controller)
	if menu == nil then
		return
	end

	if menu.actionSlotLabel1 ~= nil then
		menu.actionSlotLabel1:setText(GetT5ActionSlotKeybindText(controller or menu.controller, 1))
	end
	if menu.actionSlotLabel2 ~= nil then
		menu.actionSlotLabel2:setText(GetT5ActionSlotKeybindText(controller or menu.controller, 2))
	end
	if menu.actionSlotLabel3 ~= nil then
		menu.actionSlotLabel3:setText(GetT5ActionSlotKeybindText(controller or menu.controller, 3))
	end
end

CoD.T5AmmoCounter.UpdateActionSlotKeybindLabels = function(menu, event)
	if event ~= nil and event.controller ~= nil then
		UpdateT5ActionSlotKeybindLabels(menu, event.controller)
	else
		UpdateT5ActionSlotKeybindLabels(menu, menu.controller)
	end
end

local function IsT5ControllerInput(menu, event)
	if event ~= nil and event.source ~= nil then
		return event.source == 0
	end

	if CoD ~= nil and CoD.useController == true and Engine ~= nil and Engine.LastInput_Gamepad ~= nil then
		local lastInputGamepad = Engine.LastInput_Gamepad()
		return lastInputGamepad == true or lastInputGamepad == 1
	end

	return false
end

local function SetT5ActionSlotPromptVisuals(menu, useController)
	if menu == nil then
		return
	end

	menu.usingControllerInput = useController == true

	local labelAlpha = 1
	local xenonAlpha = 0

	if menu.usingControllerInput == true then
		labelAlpha = 0
		xenonAlpha = 1
	end

	if menu.dpadXenon ~= nil then
		menu.dpadXenon:setAlpha(xenonAlpha)
	end

	if menu.actionSlotLabel1 ~= nil then
		menu.actionSlotLabel1:setAlpha(labelAlpha)
	end
	if menu.actionSlotLabel2 ~= nil then
		menu.actionSlotLabel2:setAlpha(labelAlpha)
	end
	if menu.actionSlotLabel3 ~= nil then
		menu.actionSlotLabel3:setAlpha(labelAlpha)
	end
end

CoD.T5AmmoCounter.UpdateInputSource = function(menu, event)
	local controller = menu.controller
	if event ~= nil and event.controller ~= nil then
		controller = event.controller
	end

	UpdateT5ActionSlotKeybindLabels(menu, controller)
	SetT5ActionSlotPromptVisuals(menu, IsT5ControllerInput(menu, event))
end

local function SetTextRGBSafe(textElement, r, g, b)
	if textElement ~= nil then
		textElement:setRGB(r, g, b)
	end
end

local function SetT5AmmoTextPositions(menu)
	if menu == nil or menu.ammoClipText == nil then
		return
	end

	local ammoStock = menu.lastAmmoStock or 0
	local ammoInClip = menu.lastAmmoInClip or 0
	local stockDigitCount = string.len(tostring(ammoStock))
	local clipDigitCount = string.len(tostring(ammoInClip))

	local clipBasePosition = 217
	local clipStepPerDigit = 19
	local clipRightPosition = clipBasePosition - (math.max(stockDigitCount - 1, 0) * clipStepPerDigit)

	if menu.ammoClipShadowText ~= nil then
		menu.ammoClipShadowText:setLeftRight(true, true, 1, clipRightPosition + 1)
	end
	menu.ammoClipText:setLeftRight(true, true, 0, clipRightPosition)
end

local function SetAmmoStockTextSafe(textElement, value)
	if value == nil or textElement == nil then
		return
	end

	textElement:setText("/ " .. tostring(value))
end

local function IsVisibilityBitSet(controller, bit)
	if controller == nil or bit == nil or UIExpression == nil or UIExpression.IsVisibilityBitSet == nil then
		return false
	end

	return UIExpression.IsVisibilityBitSet(controller, bit) == 1
end

local function RegisterBitHandler(menu, bit)
	if bit ~= nil then
		menu:registerEventHandler("hud_update_bit_" .. bit, CoD.T5AmmoCounter.UpdateVisibility)
	end
end

local function GetController(menu, event)
	if event ~= nil and event.controller ~= nil then
		return event.controller
	end

	return menu.controller
end

local function CanShowByVisibilityBits(controller)
	if controller == nil then
		return true
	end

	if IsVisibilityBitSet(controller, CoD.BIT_HUD_VISIBLE) ~= true then
		return false
	end

	if IsVisibilityBitSet(controller, CoD.BIT_EMP_ACTIVE) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_IN_VEHICLE) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_IN_GUIDED_MISSILE) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_AMMO_COUNTER_HIDE) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_IS_FLASH_BANGED) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_UI_ACTIVE) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_SCOREBOARD_OPEN) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_IN_KILLCAM) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_IS_SCOPED) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_PLAYER_DEAD) then
		return false
	elseif IsVisibilityBitSet(controller, CoD.BIT_IS_PLAYER_ZOMBIE) then
		return false
	end

	if CoD.FSM_VISIBILITY ~= nil and CoD.FSM_VISIBILITY(controller) ~= 0 then
		return false
	end

	return true
end

local function ApplyCounterAlpha(menu, alpha, duration)
	if menu == nil then
		return
	end

	if alpha == nil then
		alpha = 1
	end

	if duration ~= nil and duration > 0 then
		menu:beginAnimation("fade", duration)
	end

	menu:setAlpha(alpha)
end

local function RegisterVisibilityHandlers(menu)
	menu:registerEventHandler("hud_update_refresh", CoD.T5AmmoCounter.UpdateVisibility)
	menu:registerEventHandler("hud_fade_dpad", CoD.T5AmmoCounter.UpdateFading)
	menu:registerEventHandler("open_ingame_menu", CoD.T5AmmoCounter.ForceHide)
	menu:registerEventHandler("t5_hud_force_hide", CoD.T5AmmoCounter.ForceHide)
	menu:registerEventHandler("t5_hud_force_show", CoD.T5AmmoCounter.ForceShow)
	menu:registerEventHandler("t5_ammo_auto_hide", CoD.T5AmmoCounter.AutoHide)

	RegisterBitHandler(menu, CoD.BIT_HUD_VISIBLE)
	RegisterBitHandler(menu, CoD.BIT_EMP_ACTIVE)
	RegisterBitHandler(menu, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM)
	RegisterBitHandler(menu, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN)
	RegisterBitHandler(menu, CoD.BIT_IN_VEHICLE)
	RegisterBitHandler(menu, CoD.BIT_IN_GUIDED_MISSILE)
	RegisterBitHandler(menu, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC)
	RegisterBitHandler(menu, CoD.BIT_AMMO_COUNTER_HIDE)
	RegisterBitHandler(menu, CoD.BIT_IS_FLASH_BANGED)
	RegisterBitHandler(menu, CoD.BIT_UI_ACTIVE)
	RegisterBitHandler(menu, CoD.BIT_SPECTATING_CLIENT)
	RegisterBitHandler(menu, CoD.BIT_SCOREBOARD_OPEN)
	RegisterBitHandler(menu, CoD.BIT_IN_KILLCAM)
	RegisterBitHandler(menu, CoD.BIT_PLAYER_DEAD)
	RegisterBitHandler(menu, CoD.BIT_IS_SCOPED)
	RegisterBitHandler(menu, CoD.BIT_IS_PLAYER_ZOMBIE)
end

local function ResetAutoHideTimer(menu)
	if menu ~= nil and menu.autoHideTimer ~= nil then
		menu.autoHideTimer:reset()
	end
end

local function ShowCounterForActivity(menu, event)
	if menu == nil or menu.forceHidden == true then
		return
	end

	menu.fadeAlpha = 1
	menu.autoHidden = nil
	CoD.T5AmmoCounter.UpdateVisibility(menu, event or { controller = menu.controller })
	ResetAutoHideTimer(menu)
end

local function SetIconAlpha(icon, visible)
	if icon == nil then
		return
	end
	if visible == true then
		icon:setAlpha(1)
	else
		icon:setAlpha(0)
	end
end

local function SetIconCount(rightIcon, middleIcon, leftIcon, backIcon, count)
	count = tonumber(count) or 0
	if count < 0 then
		count = 0
	elseif count > 4 then
		count = 4
	end

	SetIconAlpha(rightIcon, count >= 1)
	SetIconAlpha(middleIcon, count >= 2)
	SetIconAlpha(leftIcon, count >= 3)
	SetIconAlpha(backIcon, count >= 4)
end

local function ClearT5ActionSlotIcons(menu)
	if menu == nil or menu.t5ActionSlotIcons == nil then
		return
	end

	for slotIndex, slotWidget in pairs(menu.t5ActionSlotIcons) do
		if slotWidget ~= nil then
			slotWidget:close()
		end
	end

	menu.t5ActionSlotIcons = {}
end

local function GetT5ActionSlotBounds(slotIndex)
	if slotIndex == 1 then
		return 1164, 1182, 645, 664
	elseif slotIndex == 2 then
		return 1208, 1226, 602, 621
	elseif slotIndex == 3 then
		return 1251, 1269, 645, 664
	end

	return nil
end

local function IsT5ActionSlotActive(slotData)
	if slotData == nil or slotData.material == nil then
		return false
	end

	if slotData.ammo ~= nil and tonumber(slotData.ammo) ~= nil then
		return tonumber(slotData.ammo) > 0
	end

	return true
end

local function SetT5ActionSlotHighlights(menu, activeSlots)
	if menu == nil then
		return
	end

	SetIconAlpha(menu.highlightLeft, activeSlots ~= nil and activeSlots[1] == true)
	SetIconAlpha(menu.highlightUp, activeSlots ~= nil and activeSlots[2] == true)
	SetIconAlpha(menu.highlightRight, activeSlots ~= nil and activeSlots[3] == true)

	SetIconAlpha(menu.highlightDown, false)
end

CoD.T5AmmoCounter.UpdateActionSlots = function(menu, event)
	if menu == nil or event == nil or event.actionSlotData == nil then
		SetT5ActionSlotHighlights(menu, nil)
		return
	end

	if menu.t5ActionSlotLayer == nil then
		menu.t5ActionSlotLayer = LUI.UIElement.new()
		menu.t5ActionSlotLayer:setLeftRight(true, true, 0, 0)
		menu.t5ActionSlotLayer:setTopBottom(true, true, 0, 0)
		menu:addElement(menu.t5ActionSlotLayer)
	end

	ClearT5ActionSlotIcons(menu)

	local activeSlots = {}

	for slotIndex, slotData in pairs(event.actionSlotData) do
		local left, right, top, bottom = GetT5ActionSlotBounds(slotIndex)
		local slotActive = IsT5ActionSlotActive(slotData)
		if left ~= nil and slotData ~= nil and slotData.material ~= nil then
			activeSlots[slotIndex] = slotActive

			local slotWidget = LUI.UIElement.new()
			SetT5RightBottomBounds(slotWidget, left, right, top, bottom)
			slotWidget:setAlpha(1)
			menu.t5ActionSlotLayer:addElement(slotWidget)
			menu.t5ActionSlotIcons[slotIndex] = slotWidget

			local slotIcon = LUI.UIImage.new()
			slotIcon:setLeftRight(true, true, 0, 0)
			slotIcon:setTopBottom(true, true, 0, 0)
			slotIcon:setImage(slotData.material)
			slotIcon:setRGB(1, 1, 1)

			if slotActive == true then
				slotIcon:setAlpha(1)
			else
				slotIcon:setAlpha(0.45)
			end

			slotWidget:addElement(slotIcon)
		end
	end

	SetT5ActionSlotHighlights(menu, activeSlots)
end

local function GetOffhandData(event, offhandType)
	if event == nil then
		return nil
	end

	if event[offhandType] ~= nil then
		return event[offhandType]
	end

	if offhandType == "lethal" then
		return event.primary or event.primaryOffhand or event.currentPrimaryOffhand
	elseif offhandType == "tactical" then
		return event.secondary or event.secondaryOffhand or event.currentSecondaryOffhand
	end

	return nil
end

local function GetOffhandAmmo(event, offhandType)
	if event == nil then
		return 0
	end

	local data = GetOffhandData(event, offhandType)
	if type(data) == "table" then
		return tonumber(data.ammo or data.count or data.quantity or data.ammoCount or data.primaryOffhandCount or data.secondaryOffhandCount) or 0
	end

	return tonumber(data) or tonumber(event[offhandType .. "Ammo"]) or tonumber(event[offhandType .. "Count"]) or 0
end

LUI.createMenu.T5AmmoCounter = function(controller)
	local menu = CoD.Menu.NewSafeAreaFromState("T5AmmoCounter", controller)
	menu:setOwner(controller)
	menu.controller = controller
	menu.fadeAlpha = 1
	menu:setAlpha(1)

	menu.autoHideTimer = LUI.UITimer.new(CoD.T5AmmoCounter.AutoHideDelay, "t5_ammo_auto_hide", false, menu)
	menu:addElement(menu.autoHideTimer)

	menu.blood = AddImage(menu, "t5_hud_dpad_blood", 1010, 1286, 586.5, 724.5, { rgb = { 0.2, 0, 0 } })
	menu.outerFrame = AddImage(menu, "t5_hud_dpad_outer_frame", 1148, 1286, 586.5, 724.5)
	menu.outerFrameRim = AddImage(menu, "t5_hud_dpad_outer_frame_rim", 1148, 1286, 586.5, 724.5)
	menu.dpadLines = AddImage(menu, "t5_hud_dpad_lines", 1012, 1205, 636.5, 731.5)
	menu.dpadLinesFade = AddImage(menu, "t5_hud_dpad_lines_fade", 1008.5, 1201.5, 636.5, 731.5)
	menu.dpadBorderLine = AddImage(menu, "t5_hud_border_dpad_line", 1012, 1205, 636.5, 731.5, { alpha = 0 })
	menu.dpadXenon = AddImage(menu, "t5_hud_dpad_xenon", 1148, 1286, 586.5, 724.5, { scale = 0.48, alpha = 0 })
	menu.dpadOverlayX = AddImage(menu, "t5_hud_dpad_overlay_x", 1148, 1286, 586.5, 724.5, { scale = 0.48, alpha = 0 })
	menu.actionSlotLabel1 = AddT5SlotLabel(menu, "T5ActionSlotLabel1", 1184, 1216, 642, 666, "[1]")
	menu.actionSlotLabel2 = AddT5SlotLabel(menu, "T5ActionSlotLabel2", 1201, 1233, 626, 650, "[2]")
	menu.actionSlotLabel3 = AddT5SlotLabel(menu, "T5ActionSlotLabel3", 1218, 1250, 642, 666, "[3]")
	CoD.T5AmmoCounter.UpdateInputSource(menu, { controller = controller })

	menu.t5AmmoTextLayer = LUI.UIElement.new()
	SetT5RightBottomBounds(menu.t5AmmoTextLayer, 0, T5_HUD_WIDTH, 0, T5_HUD_HEIGHT)
	menu:addElement(menu.t5AmmoTextLayer)

	menu.ammoClipShadowText = AddT5Text(menu.t5AmmoTextLayer, true, true, 1, 199, false, true, -84, -4, "30", 0.5, LUI.Alignment.Right, { 0, 0, 0 })
	menu.ammoClipText = AddT5Text(menu.t5AmmoTextLayer, true, true, 0, 198, false, true, -85, -5, "30", 0.5, LUI.Alignment.Right, { 1, 1, 1 })
	menu.ammoStockShadowText = AddT5Text(menu.t5AmmoTextLayer, true, true, 1, 258, false, true, -70, -14, "/ 355", 0.5, LUI.Alignment.Right, { 0, 0, 0 })
	menu.ammoStockText = AddT5Text(menu.t5AmmoTextLayer, true, true, 0, 257, false, true, -71, -15, "/ 355", 0.5, LUI.Alignment.Right, { 1, 1, 1 })
	menu.weaponNameShadowText = AddT5Text(menu.t5AmmoTextLayer, true, true, 1, 259, false, true, -96, -51, "1911", 0.5, LUI.Alignment.Right, { 0, 0, 0 })
	menu.weaponNameText = AddT5Text(menu.t5AmmoTextLayer, true, true, 0, 258, false, true, -97, -52, "1911", 0.5, LUI.Alignment.Right, { 1, 1, 1 })

	menu.highlightUp = AddImage(menu, "t5_hud_dpad_outer_frame_highlight_up", 1145.5, 1283.5, 553.5, 691.5, { alpha = 0 })
	menu.highlightDown = AddImage(menu, "t5_hud_dpad_outer_frame_highlight_up", 1150.5, 1288.5, 619.5, 757.5, { zRot = 180, alpha = 0 })
	menu.highlightLeft = AddImage(menu, "t5_hud_dpad_outer_frame_highlight_left", 1114, 1252, 588, 726, { alpha = 0 })
	menu.highlightRight = AddImage(menu, "t5_hud_dpad_outer_frame_highlight_right", 1182, 1320, 585, 723, { alpha = 0 })
	menu.grenadeIcon0 = AddImage(menu, "t5_grenadeicon", 1128, 1153, 693, 718)
	menu.grenadeIcon1 = AddImage(menu, "t5_grenadeicon", 1134, 1159, 693, 718)
	menu.grenadeIcon2 = AddImage(menu, "t5_grenadeicon", 1140, 1165, 693, 718)
	menu.grenadeIcon3 = AddImage(menu, "t5_grenadeicon", 1146, 1171, 693, 718)
	menu.monkeyIcon1 = AddImage(menu, "t5_hud_cymbal_monkey", 1088, 1110, 696, 718)
	menu.monkeyIcon2 = AddImage(menu, "t5_hud_cymbal_monkey", 1095, 1117, 696, 718)
	menu.monkeyIcon3 = AddImage(menu, "t5_hud_cymbal_monkey", 1103, 1125, 696, 718)

	SetIconCount(menu.grenadeIcon3, menu.grenadeIcon2, menu.grenadeIcon1, menu.grenadeIcon0, 0)
	SetIconCount(menu.monkeyIcon3, menu.monkeyIcon2, menu.monkeyIcon1, nil, 0)
	SetIconAlpha(menu.highlightLeft, false)
	SetIconAlpha(menu.highlightUp, false)
	SetIconAlpha(menu.highlightRight, false)
	SetIconAlpha(menu.highlightDown, false)

	menu.t5ActionSlotIcons = {}
	menu.t5ActionSlotLayer = LUI.UIElement.new()
	menu.t5ActionSlotLayer:setLeftRight(true, true, 0, 0)
	menu.t5ActionSlotLayer:setTopBottom(true, true, 0, 0)
	menu:addElement(menu.t5ActionSlotLayer)

	menu:registerEventHandler("hud_update_actionslots", CoD.T5AmmoCounter.UpdateActionSlots)
	menu:registerEventHandler("hud_update_ammo", CoD.T5AmmoCounter.UpdateAmmo)
	menu:registerEventHandler("hud_update_offhand", CoD.T5AmmoCounter.UpdateOffhand)
	menu:registerEventHandler("hud_update_weapon", CoD.T5AmmoCounter.UpdateWeapon)
	menu:registerEventHandler("hud_update_weapon_select", CoD.T5AmmoCounter.UpdateWeaponName)
	menu:registerEventHandler("input_source_changed", CoD.T5AmmoCounter.UpdateInputSource)
	menu:registerEventHandler("hud_update_refresh", CoD.T5AmmoCounter.UpdateInputSource)
	RegisterVisibilityHandlers(menu)
	CoD.T5AmmoCounter.UpdateVisibility(menu, { controller = controller })
	return menu
end

CoD.T5AmmoCounter.UpdateOffhand = function(menu, event)
	local lethalCount = GetOffhandAmmo(event, "lethal")
	local tacticalCount = GetOffhandAmmo(event, "tactical")
	local changed = menu.lastLethalCount ~= lethalCount or menu.lastTacticalCount ~= tacticalCount

	menu.lastLethalCount = lethalCount
	menu.lastTacticalCount = tacticalCount

	SetIconCount(menu.grenadeIcon3, menu.grenadeIcon2, menu.grenadeIcon1, menu.grenadeIcon0, lethalCount)
	SetIconCount(menu.monkeyIcon3, menu.monkeyIcon2, menu.monkeyIcon1, nil, tacticalCount)

	if changed then
		ShowCounterForActivity(menu, event)
	end
end

CoD.T5AmmoCounter.UpdateAmmo = function(menu, event)
	local changed = false

	if event.ammoInClip ~= nil and menu.lastAmmoInClip ~= event.ammoInClip then
		changed = true
	end

	if event.ammoStock ~= nil and menu.lastAmmoStock ~= event.ammoStock then
		changed = true
	end

	SetTextSafe(menu.ammoClipText, event.ammoInClip, false)
	SetTextSafe(menu.ammoClipShadowText, event.ammoInClip, false)
	SetAmmoStockTextSafe(menu.ammoStockText, event.ammoStock)
	SetAmmoStockTextSafe(menu.ammoStockShadowText, event.ammoStock)

	if event.ammoInClip ~= nil then
		menu.lastAmmoInClip = event.ammoInClip
	end

	if event.ammoStock ~= nil then
		menu.lastAmmoStock = event.ammoStock
	end

	SetT5AmmoTextPositions(menu)
	if event.lowClip then
		SetTextRGBSafe(menu.ammoClipText, 1, 0.24, 0.22)
		if menu.lowAmmo ~= true then
			menu.lowAmmo = true
			menu.ammoClipText:beginAnimation("pulse_low", CoD.T5AmmoCounter.LowAmmoFadeTime)
			menu.ammoClipText:setAlpha(0.55)
		end
	elseif menu.lowAmmo == true then
		menu.lowAmmo = nil
		SetTextRGBSafe(menu.ammoClipText, 1, 1, 1)
		menu.ammoClipText:beginAnimation("pulse_default", CoD.T5AmmoCounter.LowAmmoFadeTime)
		menu.ammoClipText:setAlpha(1)
	else
		SetTextRGBSafe(menu.ammoClipText, 1, 1, 1)
	end

	if tonumber(menu.lastAmmoStock) == 0 then
		SetTextRGBSafe(menu.ammoStockText, 1, 0.24, 0.22)
	else
		SetTextRGBSafe(menu.ammoStockText, 1, 1, 1)
	end

	SetTextRGBSafe(menu.ammoClipShadowText, 0, 0, 0)
	SetTextRGBSafe(menu.ammoStockShadowText, 0, 0, 0)

	if changed then
		ShowCounterForActivity(menu, event)
	end
end

CoD.T5AmmoCounter.UpdateWeaponName = function(menu, event)
	local weaponText = nil

	if event.weaponDisplayName ~= nil then
		weaponText = event.weaponDisplayName
	elseif event.weaponName ~= nil then
		weaponText = event.weaponName
	elseif event.weapon ~= nil then
		weaponText = event.weapon
	end

	if weaponText ~= nil then
		if menu.lastWeaponText ~= weaponText then
			menu.lastWeaponText = weaponText
			ShowCounterForActivity(menu, event)
		end

		SetTextSafe(menu.weaponNameText, weaponText, true)
		SetTextSafe(menu.weaponNameShadowText, weaponText, true)
		SetTextRGBSafe(menu.weaponNameText, 1, 1, 1)
		SetTextRGBSafe(menu.weaponNameShadowText, 0, 0, 0)
	end
end

CoD.T5AmmoCounter.ShouldHide = function(menu, event)
	local controller = GetController(menu, event)

	if CanShowByVisibilityBits(controller) ~= true then
		return true
	end

	if event ~= nil and event.weapon ~= nil then
		menu.weapon = event.weapon
	end

	if menu.weapon ~= nil then
		if Engine.IsWeaponType(menu.weapon, "melee") then
			return true
		elseif event ~= nil and (event.inventorytype == 1 or event.inventorytype == 2) then
			return true
		elseif Engine.IsWeaponType(menu.weapon, "gas") or Engine.IsOverheatWeapon(menu.weapon) then
			return true
		end
	end

	return false
end

CoD.T5AmmoCounter.ForceHide = function(menu, event)
	menu.forceHidden = true
	ApplyCounterAlpha(menu, 0, 100)
	menu.visible = false
end

CoD.T5AmmoCounter.ForceShow = function(menu, event)
	menu.forceHidden = nil
	ShowCounterForActivity(menu, event)
end

CoD.T5AmmoCounter.UpdateVisibility = function(menu, event)
	if menu.forceHidden == true then
		ApplyCounterAlpha(menu, 0, 100)
		menu.visible = false
		return
	end

	if CoD.T5AmmoCounter.ShouldHide(menu, event) then
		if menu.visible ~= false then
			ApplyCounterAlpha(menu, 0, 100)
			menu.visible = false
		end
	else
		if menu.visible ~= true then
			menu.visible = true
		end

		ApplyCounterAlpha(menu, menu.fadeAlpha or 1, 100)
	end
end

CoD.T5AmmoCounter.UpdateFading = function(menu, event)
	local controller = GetController(menu, event)

	if menu.forceHidden == true then
		ApplyCounterAlpha(menu, 0, 0)
		return
	end

	if event ~= nil and event.alpha ~= nil then
		menu.fadeAlpha = event.alpha
	end

	if CanShowByVisibilityBits(controller) ~= true then
		return
	end

	if event ~= nil and event.alpha == 0 then
		ApplyCounterAlpha(menu, event.alpha, CoD.T5AmmoCounter.AutoHideFadeTime)
	elseif event ~= nil and event.alpha == 1 then
		ShowCounterForActivity(menu, event)
	else
		ApplyCounterAlpha(menu, menu.fadeAlpha or 1, 0)
	end
end

CoD.T5AmmoCounter.AutoHide = function(menu, event)
	if menu.forceHidden == true then
		return
	end

	if CoD.T5AmmoCounter.ShouldHide(menu, event) then
		return
	end

	menu.fadeAlpha = 0
	menu.autoHidden = true
	ApplyCounterAlpha(menu, 0, CoD.T5AmmoCounter.AutoHideFadeTime)
end

CoD.T5AmmoCounter.UpdateWeapon = function(menu, event)
	CoD.T5AmmoCounter.UpdateWeaponName(menu, event)
	CoD.T5AmmoCounter.UpdateVisibility(menu, event)
end
