## Utility helpers for extending and interacting with PopupMenu nodes.
class_name GrapplerPopupMenus
extends Object

## Adds an item with an icon to a PopupMenu and binds an action to its ID.
##
## - `id`: Unique identifier for the menu item
## - `icon`: Icon texture displayed next to the label
## - `label`: Visible text
## - `action`: Callable executed when the item is pressed
static func add_icon_item(menu: PopupMenu, id: int, icon: Texture2D, label: String, action: Callable):
	extend_popup_menu(menu,
		# Runs when menu opens
		func(): menu.add_icon_item(icon, label, id),
		# Runs when an item is pressed
		func(pressed_id): if pressed_id == id: action.call()
	)

## Adds a text-only item to a PopupMenu and binds an action to its ID.
##
## - `id`: Unique identifier for the menu item
## - `label`: Visible text
## - `action`: Callable executed when pressed
static func add_item(menu: PopupMenu, id: int, label: String, action: Callable):
	extend_popup_menu(menu,
		func(): menu.add_item(label, id),
		func(pressed_id): if pressed_id == id: action.call()
	)

## Adds a separator line to the menu when it becomes visible.
##
## Optional label can be used to name the section.
static func add_separator(menu: PopupMenu, label: String = ""):
	menu.visibility_changed.connect(func():
		menu.add_separator(label)
	)

## Used to add items to a popup menu. This is called when the popup menu is
## opened, so items can even be added to menus that dynamically change.
##
## - `on_open`: Called when the menu becomes visible (good for injecting items)
## - `on_id_pressed`: Called when any item is pressed
##
static func extend_popup_menu(menu: PopupMenu, on_open: Callable, on_id_pressed: Callable):
	menu.visibility_changed.connect(on_open)
	menu.id_pressed.connect(on_id_pressed)

## Finds a menu item ID by its visible text.
static func get_id_from_text(menu: PopupMenu, text: String) -> int:
	for i in range(0, menu.item_count):
		var item_text = menu.get_item_text(i)
		if item_text == text:
			return menu.get_item_id(i)
	return -1

## Simulates selecting a menu item by emitting its id_pressed signal.
static func simulate_id_pressed(menu: PopupMenu, id: int):
	menu.id_pressed.emit(id)
