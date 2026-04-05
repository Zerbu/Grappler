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

@tool
## Provides structured access to the "Layouts" dialog from Editor > Editor Layout.
extends Node

## The layouts dialog itself.
var layouts_dialog: ConfirmationDialog

## The main vertical container of the dialog.
var layouts_main_vbox: VBoxContainer

## The container for the item list containing the layouts.
var layouts_item_list_margin_container: MarginContainer

## The item list containing the layouts.
var layouts_item_list: ItemList

## The line edit for entering a new layout name.
var layout_name_line_edit: LineEdit

## The main horizontal container with buttons.
var layouts_buttons_hbox: HBoxContainer

## The "Save" or "Delete" button.
var save_or_delete_button: Button

## The "Cancel" button.
var cancel_button: Button

func _ready() -> void:
	if not Engine.is_editor_hint():
		return
	
	layouts_dialog 						= GrapplerBase.base.find_child("?EditorLayoutsDialog*", true, false)
	layouts_main_vbox 					= layouts_dialog.find_child("?VBoxContainer*", true, false)
	layouts_item_list_margin_container 	= layouts_main_vbox.get_child(1)
	layouts_item_list 					= layouts_item_list_margin_container.get_child(0)
	layout_name_line_edit 				= layouts_main_vbox.get_child(2)
	layouts_buttons_hbox 				= layouts_dialog.find_child("?HBoxContainer*", true, false)
	save_or_delete_button 				= layouts_buttons_hbox.get_child(1)
	cancel_button 						= layouts_buttons_hbox.get_child(3)

## Opens the dialog and saves a scene.
func force_save_layout(layout_name: String):
	GrapplerPopupMenuUtils	.simulate_id_pressed(GrapplerTitleBar.editor_layouts_menu, 44)
	GrapplerLayoutsDialog	.layout_name_line_edit.text 	= layout_name
	GrapplerLayoutsDialog	.save_or_delete_button.disabled = false
	GrapplerLayoutsDialog	.save_or_delete_button.pressed.emit()
