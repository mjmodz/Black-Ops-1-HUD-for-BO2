require("T6.HUD.InGameMenus")
require("LUI.LUITimer")

CoD.T5PauseMenu = CoD.T5PauseMenu or {}
CoD.T5PauseMenu.StoredHudRefs = CoD.T5PauseMenu.StoredHudRefs or {}

local PAUSE_BUTTON_TEXT_LEFT = 79
local PAUSE_BUTTON_TEXT_RIGHT = 370

local PAUSE_TITLE_TEXT_LEFT = PAUSE_BUTTON_TEXT_LEFT + 10
local PAUSE_TITLE_TEXT_RIGHT = PAUSE_TITLE_TEXT_LEFT + 104

local BUTTON_BACKING_LEFT = 72
local BUTTON_BACKING_RIGHT = 380
local BUTTON_BACKING_ALPHA = 0.30

local EDGE_SOLID_HEIGHT = 20
local EDGE_FADE_HEIGHT = 70
local EDGE_FADE_STEPS = 70
local EDGE_FADE_EXTRA_ALPHA = 0.60

local PAUSE_BUTTONS = {
	{ text = "RESUME CARNAGE", action = "pause_resume_game", left = PAUSE_BUTTON_TEXT_LEFT, right = PAUSE_BUTTON_TEXT_RIGHT, top = 114, bottom = 136, highlightTop = 113, highlightBottom = 137 },
	{ text = "OPTIONS", action = "pause_open_options", left = PAUSE_BUTTON_TEXT_LEFT, right = PAUSE_BUTTON_TEXT_RIGHT, top = 142, bottom = 164, highlightTop = 141, highlightBottom = 165 },
	{ text = "RESTART LEVEL", action = "pause_restart_level", left = PAUSE_BUTTON_TEXT_LEFT, right = PAUSE_BUTTON_TEXT_RIGHT, top = 170, bottom = 192, highlightTop = 169, highlightBottom = 193 },
	{ text = "END GAME", action = "pause_end_game", left = PAUSE_BUTTON_TEXT_LEFT, right = PAUSE_BUTTON_TEXT_RIGHT, top = 198, bottom = 220, highlightTop = 197, highlightBottom = 221 }
}

local function ShowCursor()
	if CoD.isPC and LUI.roots ~= nil and LUI.roots.UIRootFull ~= nil and LUI.roots.UIRootFull.mouseCursor ~= nil then
		LUI.roots.UIRootFull.mouseCursor:setPriority((LUI.UIMouseCursor and LUI.UIMouseCursor.priority) or 1000)
		LUI.roots.UIRootFull.mouseCursor:setAlpha(0)
	end
end

local function HideCursor()
	if CoD.isPC and LUI.roots ~= nil and LUI.roots.UIRootFull ~= nil and LUI.roots.UIRootFull.mouseCursor ~= nil then
		LUI.roots.UIRootFull.mouseCursor:setAlpha(0)
	end
end

local function RestoreGame(menu, controller)
	local hudRef = nil
	if menu ~= nil then
		hudRef = menu.gameHud
	end

	if hudRef ~= nil then
		hudRef.t5PauseMenu = nil
		hudRef:setAlpha(1)
		hudRef:dispatchEventToChildren({
			name = "t5_hud_force_show",
			controller = controller
		})

		if hudRef.SpectateHUD ~= nil then
			hudRef.SpectateHUD:processEvent({
				name = "spectate_ingame_menu_closed"
			})
		end
	end

	if CoD.T5PauseMenu.StoredHudRefs ~= nil then
		CoD.T5PauseMenu.StoredHudRefs[controller + 1] = nil
	end

	if CoD.InGameMenu.m_unpauseDisabled == nil then
		CoD.InGameMenu.m_unpauseDisabled = {}
	end
	CoD.InGameMenu.m_unpauseDisabled[controller + 1] = 0

	Engine.SetActiveMenu(controller, CoD.UIMENU_NONE)
	Engine.BlurWorld(controller, 0)
	Engine.LockInput(controller, false)
	Engine.SetUIActive(controller, false)

	if CoD.isPC then
		Engine.SetForceMouseRootFull(false)
		HideCursor()

		if CoD.Mouse ~= nil then
			CoD.Mouse.InGrabMode = false
			CoD.Mouse.Reset = true
			CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		end
	end
end

local function OpenChild(menu, controller, menuName, previousMenuName)
	if menu == nil or controller == nil then
		return true
	end

	if CoD.T5PauseMenu.StoredHudRefs == nil then
		CoD.T5PauseMenu.StoredHudRefs = {}
	end

	local hudRef = menu.gameHud
	if hudRef ~= nil then
		CoD.T5PauseMenu.StoredHudRefs[controller + 1] = hudRef
		hudRef.t5PauseMenu = nil
	end

	local nextMenu = menu:openMenu(menuName, controller)
	if nextMenu ~= nil and nextMenu.setPreviousMenu ~= nil and previousMenuName ~= nil then
		nextMenu:setPreviousMenu(previousMenuName)
	end

	CoD.Menu.close(menu)
	return true
end

local function OpenConfirm(menu, controller, confirmAction)
	if menu == nil or controller == nil then
		return true
	end

	if CoD.T5PauseMenu.StoredHudRefs == nil then
		CoD.T5PauseMenu.StoredHudRefs = {}
	end

	CoD.T5ConfirmMenu = CoD.T5ConfirmMenu or {}
	CoD.T5ConfirmMenu.PendingAction = CoD.T5ConfirmMenu.PendingAction or {}
	CoD.T5ConfirmMenu.PendingAction[controller + 1] = confirmAction

	local hudRef = menu.gameHud
	if hudRef ~= nil then
		CoD.T5PauseMenu.StoredHudRefs[controller + 1] = hudRef
		hudRef.t5PauseMenu = nil
	end

	local nextMenu = menu:openMenu("T5ConfirmMenu", controller)
	if nextMenu ~= nil and nextMenu.setPreviousMenu ~= nil then
		nextMenu:setPreviousMenu("T5PauseMenu")
	end

	CoD.Menu.close(menu)
	return true
end

CoD.T5PauseMenu.Close = function(menu, event)
	local controller = 0
	if event ~= nil and event.controller ~= nil then
		controller = event.controller
	elseif menu ~= nil and menu.controller ~= nil then
		controller = menu.controller
	end

	RestoreGame(menu, controller)
	CoD.Menu.close(menu)
	return true
end

CoD.T5PauseMenu.ResumePressed = function(menu, event)
	return CoD.T5PauseMenu.Close(menu, event)
end

CoD.T5PauseMenu.OpenOptionsPressed = function(menu, event)
	if event ~= nil and event.controller ~= nil then
		return OpenChild(menu, event.controller, "T5OptionsMenu", "T5PauseMenu")
	end

	return true
end

CoD.T5PauseMenu.RestartPressed = function(menu, event)
	if event ~= nil and event.controller ~= nil then
		Engine.PlaySound("uin_main_pause")
		return OpenConfirm(menu, event.controller, "restart")
	end

	return true
end

CoD.T5PauseMenu.EndGamePressed = function(menu, event)
	if event ~= nil and event.controller ~= nil then
		Engine.PlaySound("uin_main_pause")
		return OpenConfirm(menu, event.controller, "end_game")
	end

	return true
end

local function KeepBlur(menu, event)
	local controller = 0
	if menu ~= nil and menu.controller ~= nil then
		controller = menu.controller
	elseif event ~= nil and event.controller ~= nil then
		controller = event.controller
	end

	Engine.BlurWorld(controller, 4)
	return true
end

local function SetupBack(menu, event)
	if menu == nil or menu.backPromptsReady == true then
		return true
	end

	CoD.InGameMenu.addButtonPrompts(menu)

	if menu.backButton ~= nil then
		menu.backButton:setAlpha(0)
		menu.backButton:setLeftRight(true, false, -500, -300)
	end

	if menu.backButtonPrompt ~= nil then
		menu.backButtonPrompt:setAlpha(0)
	end

	if menu.startButtonPrompt ~= nil then
		menu.startButtonPrompt:setAlpha(0)
	end

	menu.backPromptsReady = true
	return true
end

local function KeepCursor(menu, event)
	ShowCursor()
	if CoD.Mouse ~= nil then
		CoD.Mouse.Reset = true
		CoD.Mouse.InGrabMode = true
		CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
	end
	return true
end

local function AddBox(parent, left, right, top, bottom, r, g, b, alpha)
	local image = LUI.UIImage.new()
	image:setLeftRight(true, false, left, right)
	image:setTopBottom(true, false, top, bottom)
	image:setImage(RegisterMaterial("white"))
	image:setRGB(r or 1, g or 1, b or 1)
	image:setAlpha(alpha or 1)
	parent:addElement(image)
	return image
end

local function AddEdgeFade(parent)
	AddBox(parent, 0, 1280, 0, EDGE_SOLID_HEIGHT, 0, 0, 0, EDGE_FADE_EXTRA_ALPHA)
	AddBox(parent, 0, 1280, 720 - EDGE_SOLID_HEIGHT, 720, 0, 0, 0, EDGE_FADE_EXTRA_ALPHA)

	local stepHeight = EDGE_FADE_HEIGHT / EDGE_FADE_STEPS

	for i = 0, EDGE_FADE_STEPS - 1 do
		local t = i / (EDGE_FADE_STEPS - 1)
		t = t * t * (3 - 2 * t)

		local top = math.floor(EDGE_SOLID_HEIGHT + (i * stepHeight))
		local bottom = math.floor(EDGE_SOLID_HEIGHT + ((i + 1) * stepHeight))
		local alpha = EDGE_FADE_EXTRA_ALPHA * (1 - t)

		AddBox(parent, 0, 1280, top, bottom, 0, 0, 0, alpha)
	end

	for i = 0, EDGE_FADE_STEPS - 1 do
		local t = i / (EDGE_FADE_STEPS - 1)
		t = t * t * (3 - 2 * t)

		local top = math.floor(720 - EDGE_SOLID_HEIGHT - EDGE_FADE_HEIGHT + (i * stepHeight))
		local bottom = math.floor(720 - EDGE_SOLID_HEIGHT - EDGE_FADE_HEIGHT + ((i + 1) * stepHeight))
		local alpha = EDGE_FADE_EXTRA_ALPHA * t

		AddBox(parent, 0, 1280, top, bottom, 0, 0, 0, alpha)
	end
end

local function AddButtonBacks(parent, buttons)
	for i = 1, #buttons, 1 do
		AddBox(parent, BUTTON_BACKING_LEFT, BUTTON_BACKING_RIGHT, buttons[i].highlightTop, buttons[i].highlightBottom, 0, 0, 0, BUTTON_BACKING_ALPHA)
	end
end

local function AddZmbIcon(parent)
	local image = LUI.UIImage.new()
	image:setLeftRight(false, true, -114, -4)
	image:setTopBottom(true, false, 638, 720)
	image:setImage(RegisterMaterial("t5_zmb_icon"))
	image:setRGB(1, 1, 1)
	image:setMouseDisabled(true)
	if image.setPriority ~= nil then
		image:setPriority(20)
	end
	parent:addElement(image)
	return image
end

local function AddLabel(parent, left, right, top, bottom, text, font, scale)
	local label = LUI.UIText.new()
	label:setLeftRight(true, false, left, right)
	label:setTopBottom(true, false, top, bottom)
	label:setFont(font or CoD.fonts.ExtraSmall)
	label:setAlignment(LUI.Alignment.Left)
	label:setRGB(1, 1, 1)
	label:setText(Engine.Localize(text))
	if scale ~= nil then
		label:setScale(scale)
	end
	parent:addElement(label)
	return label
end

local function HideHover(menu)
	if menu == nil or menu.highlight == nil then
		return
	end

	menu.highlight:setAlpha(0)
	menu.currentButton = nil
end

local function MoveHover(menu, button)
	if menu == nil or menu.highlight == nil or button == nil then
		return
	end

	menu.highlight:setLeftRight(true, false, BUTTON_BACKING_LEFT, BUTTON_BACKING_RIGHT)
	menu.highlight:setTopBottom(true, false, button.highlightTop, button.highlightBottom)
	menu.highlight:setAlpha(1)
	menu.currentButton = button
end

local function FocusButton(menu, button, focused)
	if button == nil then
		return
	end

	if focused and button.mouseHovering == true then
		MoveHover(menu, button)
		if button.label ~= nil then
			button.label:setRGB(0, 0, 0)
		end
	else
		if button.label ~= nil then
			button.label:setRGB(1, 1, 1)
		end
	end
end

local function RunButton(parent, actionEvent, event)
	parent:processEvent({
		name = actionEvent,
		controller = (event ~= nil and event.controller) or parent.controller
	})
	return true
end

local function AddButton(parent, info)
	local button = LUI.UIElement.new()
	button:setLeftRight(true, false, 72, 400)
	button:setTopBottom(true, false, info.highlightTop, info.highlightBottom)
	button:makeFocusable()
	button:setHandleMouse(true)
	button:setHandleMouseAnim(true)
	button:setMouseDisabled(false)
	button.id = "pause_" .. info.action
	button.action = info.action
	button.highlightTop = info.highlightTop
	button.highlightBottom = info.highlightBottom

	local hitbox = AddBox(button, 0, 328, 0, info.highlightBottom - info.highlightTop, 1, 1, 1, 0)
	button.hitbox = hitbox

	button.label = AddLabel(parent, info.left, info.right, info.top, info.bottom, info.text, CoD.fonts.ExtraSmall, 0.75)

	button:registerEventHandler("gain_focus", function(buttonElement, event)
		if parent.currentButton ~= buttonElement then
			Engine.PlaySound("uin_main_pause")
		end

		buttonElement:setFocus(true)
		LUI.currentMouseFocus = buttonElement
		FocusButton(parent, buttonElement, true)

		if CoD.Mouse ~= nil then
			CoD.Mouse.InGrabMode = true
			CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_GRABOPEN)
		end

		return true
	end)

	button:registerEventHandler("mouseenter", function(buttonElement, event)
		buttonElement.mouseHovering = true
		buttonElement:processEvent({
			name = "gain_focus",
			controller = (event ~= nil and event.controller) or parent.controller
		})
		return true
	end)

	button:registerEventHandler("mouseleave", function(buttonElement, event)
		buttonElement.mouseHovering = false
		HideHover(parent)
		if buttonElement.label ~= nil then
			buttonElement.label:setRGB(1, 1, 1)
		end

		if CoD.Mouse ~= nil then
			CoD.Mouse.InGrabMode = false
			CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		end

		return true
	end)

	button:registerEventHandler("lose_focus", function(buttonElement, event)
		buttonElement:setFocus(false)
		buttonElement.mouseHovering = false
		FocusButton(parent, buttonElement, false)
		HideHover(parent)

		if CoD.Mouse ~= nil then
			CoD.Mouse.InGrabMode = false
			CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		end

		return true
	end)

	button:registerEventHandler("leftmouseup", function(buttonElement, event)
		if event ~= nil and event.inside == false then
			return true
		end

		Engine.PlaySound("uin_main_pause")
		return RunButton(parent, info.action, event)
	end)

	button:registerEventHandler("button_action", function(buttonElement, event)
		Engine.PlaySound("uin_main_pause")
		return RunButton(parent, info.action, event)
	end)

	button:registerEventHandler("leftmousedown", function(buttonElement, event)
		if CoD.Mouse ~= nil then
			CoD.Mouse.InGrabMode = true
			CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_GRABCLOSE)
		end
		return true
	end)

	parent:addElement(button)
	return button
end

local function WireButtons(buttons)
	for i = 1, #buttons, 1 do
		local previousIndex = i - 1
		local nextIndex = i + 1
		if previousIndex < 1 then
			previousIndex = #buttons
		end
		if nextIndex > #buttons then
			nextIndex = 1
		end

		buttons[i].navigation = buttons[i].navigation or {}
		buttons[i].navigation.up = buttons[previousIndex]
		buttons[i].navigation.down = buttons[nextIndex]
	end
end

LUI.createMenu.T5PauseMenu = function(controller)
	local menu = CoD.Menu.NewFromState("T5PauseMenu", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})

	menu:setOwner(controller)
	menu.controller = controller
	menu:setPriority(100)
	menu:setMouseDisabled(false)
	menu.gameHud = nil
	menu.backPromptsReady = false
	menu.currentButton = nil

	if CoD.T5PauseMenu.StoredHudRefs ~= nil then
		menu.gameHud = CoD.T5PauseMenu.StoredHudRefs[controller + 1]
		if menu.gameHud ~= nil then
			menu.gameHud.t5PauseMenu = menu
		end
	end

	if CoD.isPC then
		Engine.SetForceMouseRootFull(true)

		if CoD.Mouse ~= nil and not CoD.Mouse.MaterialsRegistered then
			CoD.Mouse.RegisterMaterials()
		end

		ShowCursor()

		if CoD.Mouse ~= nil then
			CoD.Mouse.Reset = true
			CoD.Mouse.InGrabMode = true
			CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		end
	end

	Engine.PlaySound("uin_main_pause")
	Engine.BlurWorld(controller, 4)

	menu:registerEventHandler("button_prompt_back", CoD.T5PauseMenu.ResumePressed)
	menu:registerEventHandler("button_prompt_start", CoD.T5PauseMenu.ResumePressed)
	menu:registerEventHandler("close_all_ingame_menus", CoD.T5PauseMenu.Close)
	menu:registerEventHandler("close_ingame_menu", CoD.T5PauseMenu.Close)
	menu:registerEventHandler("t5_internal_close", CoD.T5PauseMenu.Close)
	menu:registerEventHandler("pause_resume_game", CoD.T5PauseMenu.ResumePressed)
	menu:registerEventHandler("pause_open_options", CoD.T5PauseMenu.OpenOptionsPressed)
	menu:registerEventHandler("pause_restart_level", CoD.T5PauseMenu.RestartPressed)
	menu:registerEventHandler("pause_end_game", CoD.T5PauseMenu.EndGamePressed)
	menu:registerEventHandler("pause_enable_back_prompts", SetupBack)
	menu:registerEventHandler("pause_force_cursor_visible", KeepCursor)
	menu:registerEventHandler("pause_unblur_world", KeepBlur)

	AddBox(menu, 0, 1280, 0, 720, 0, 0, 0, 0.53)

	AddEdgeFade(menu)

	AddButtonBacks(menu, PAUSE_BUTTONS)

	menu.highlight = AddBox(menu, BUTTON_BACKING_LEFT, BUTTON_BACKING_RIGHT, 113, 137, 1, 1, 1, 0)

	AddLabel(menu, PAUSE_TITLE_TEXT_LEFT, PAUSE_TITLE_TEXT_RIGHT, 63, 105, "PAUSED", CoD.fonts.Condensed, 1.10)

	menu.zmbIcon = AddZmbIcon(menu)

	menu.buttons = {}
	for i = 1, #PAUSE_BUTTONS, 1 do
		menu.buttons[i] = AddButton(menu, PAUSE_BUTTONS[i])
	end

	WireButtons(menu.buttons)

	menu:addElement(LUI.UITimer.new(1, "pause_unblur_world", true, menu))
	menu:addElement(LUI.UITimer.new(1, "pause_force_cursor_visible", true, menu))
	menu:addElement(LUI.UITimer.new(75, "pause_enable_back_prompts", true, menu))

	return menu
end
