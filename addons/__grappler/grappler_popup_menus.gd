'''
MIT License

Copyright (c) 2026 Zerbu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'''

## Utility helpers for extending and interacting with PopupMenu nodes.
class_name GrapplerPopupMenus
extends Object

## Adds an item with an icon to a PopupMenu and binds an action to its ID.
static func add_icon_item(menu: PopupMenu, id: int, icon: Texture2D,
label: String, action: Callable):
	extend_popup_menu(menu,
		# Runs when menu opens
		func(): menu.add_icon_item(icon, label, id),
		# Runs when an item is pressed
		func(pressed_id): if pressed_id == id: action.call()
	)

## Adds a text-only item to a PopupMenu and binds an action to its ID.
static func add_item(menu: PopupMenu, id: int, label: String, action: Callable):
	extend_popup_menu(menu,
		func(): menu.add_item(label, id),
		func(pressed_id): if pressed_id == id: action.call()
	)

## Adds a separator line to the menu when it becomes visible.
static func add_separator(menu: PopupMenu, label: String = ""):
	menu.visibility_changed.connect(func():
		menu.add_separator(label)
	)

## Used to add custom items to a changing menu.
## [param on_open]: Called when the menu becomes visible
## (good for injecting items)
## [param on_id_pressed]: Called when any item is pressed
static func extend_popup_menu(menu: PopupMenu, on_open: Callable,
on_id_pressed: Callable):
	menu.visibility_changed.connect(on_open)
	menu.id_pressed.connect(on_id_pressed)

## Finds a menu item's ID by its visible text.
static func get_id_from_text(menu: PopupMenu, text: String) -> int:
	for i in range(0, menu.item_count):
		var item_text = menu.get_item_text(i)
		if item_text == text:
			return menu.get_item_id(i)
	return -1

## Simulates selecting a menu item by emitting its [member id_pressed] signal.
static func simulate_id_pressed(menu: PopupMenu, id: int):
	menu.id_pressed.emit(id)
