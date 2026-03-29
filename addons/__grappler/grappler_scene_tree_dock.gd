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
## Provides structured access to the Scene Tree dock and its UI elements.
extends Node

## Emitted when the helper class is initialized.
signal initialized

## [constant true] if the helper class is initialized,
## [constant false] otherwise.
var is_initialized: bool = false

## The scene tree dock itself.
var scene_tree_dock: EditorDock

## The main vertical container of the dock.
var scene_tree_dock_vbox: VBoxContainer

## The top row containing scene actions.
var scene_tree_main_header: HBoxContainer

## The "Add Child Node" button.
var add_child_node_button: Button

## The "Instantiate Child Scene" button.
var instantiate_child_scene_button: Button

## The "Filter Nodes" line edit.
var filter_nodes_line_edit: LineEdit

## The "Attach Script" button.
var attach_script_button: Button

## The "Remove Script" button.
var remove_script_button: Button 

## The "Change Script" button.
var change_script_button: Button

## The header containing "Local" and "Remote" buttons.
## Only visible while the project is running.
var remote_local_header: HBoxContainer

## The "Remote" button.
## Only visible while the project is running.
var remote_button: Button

## The "Local" button.
## Only visible while the project is running.
var local_button: Button

## The container holding either the "Add Root Node" UI or the scene tree,
## depending on whether 
var main_margin_container: MarginContainer

## The "Add Root Node" vertical container [b]outside[/b] the scroll container.
## Shown whene the scene is empty.
var add_root_node_vbox: VBoxContainer

## The "Add Root Node" scroll container.
## Shown whene the scene is empty.
var add_root_node_scroll_container: ScrollContainer

## The "Add Root Node" vertical container [b]inside[/b] the scroll container.
## Shown whene the scene is empty.
var add_root_node_scroll_container_vbox: VBoxContainer

## The header for the "Add Root Node" menu.
## Shown whene the scene is empty.
var add_root_node_header: HBoxContainer

## The "Add Root Node" buttons.
## Shown whene the scene is empty.
var add_root_node_buttons: VBoxContainer

## The button create a root "2D Scene" node.
## Shown whene the scene is empty.
var add_root_node_2d_button: Button

## The button create a root "3D Scene" node.
## Shown whene the scene is empty.
var add_root_node_3d_button: Button

## The button create a root "User Interface" node.
## Shown whene the scene is empty.
var add_root_node_ui_button: Button

## The button create a root "Other Node" node.
## Shown whene the scene is empty.
var add_root_node_other_button: Button

## The "Paste from Clipboard" button.
## Shown whene the scene is empty.
var add_root_node_paste_button: Button

## The container for the main scene tree.
var main_scene_tree_editor: Control

## The main scene tree, containing all the nodes.
var main_scene_tree: Tree

## The right-click context menu for the scene tree.
var node_popup_menu: PopupMenu

## If the helper class is initialized, the [param callable] parameter
## will be called right away. Otherwise, it will be called when
## [signal initialized] is emitted.
func when_initialized(callable: Callable):
	if not Engine.is_editor_hint():
		return
	if is_initialized:
		callable.call()
		return
	initialized.connect(callable)

## Adds a control to the main header of the scene tree dock.
func add_to_scene_tree_main_header(control: Control, index: int = -1):
	scene_tree_main_header.add_child(control)
	scene_tree_main_header.move_child(control, index)

## Removes a control from the main header of the scene tree dock.
func remove_from_scene_tree_main_header(control: Control):
	scene_tree_dock_vbox.remove_child(control)

## Adds a control to the "Add Root Node" button list.
func add_to_root_node_buttons(control: Control, index: int = -1):
	add_root_node_buttons.add_child(control)
	add_root_node_buttons.move_child(control, index)

## Removes a control from the "Add Root Node" button list.
func remove_from_add_root_node_buttons(control: Control):
	scene_tree_dock_vbox.remove_child(control)

func _ready() -> void:
	_try_initialize()

func _try_initialize() -> bool:
	if not Engine.is_editor_hint():
		return false
	
	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	
	var dock_base = autoload.base.find_child("DockHSplitMain", true, false)
	if dock_base == null:
		autoload.base.child_entered_tree.connect(_retry_initialize)
		return false

	var dock = dock_base.find_child("Scene", true, false)

	scene_tree_dock = dock
	scene_tree_dock_vbox = scene_tree_dock.get_child(0)
	scene_tree_main_header = scene_tree_dock_vbox.get_child(0)

	add_child_node_button = scene_tree_main_header.get_child(0)
	instantiate_child_scene_button = scene_tree_main_header.get_child(1)
	filter_nodes_line_edit = scene_tree_main_header.get_child(2)
	attach_script_button = scene_tree_main_header.get_child(3)
	remove_script_button = scene_tree_main_header.get_child(4)
	change_script_button = scene_tree_main_header.get_child(5)

	remote_local_header = scene_tree_dock_vbox.get_child(1)
	remote_button = remote_local_header.get_child(0)
	local_button = remote_local_header.get_child(1)

	main_margin_container = scene_tree_dock_vbox.get_child(2)
	add_root_node_vbox = main_margin_container.get_child(0)

	add_root_node_scroll_container = add_root_node_vbox.get_child(1)
	add_root_node_scroll_container_vbox = add_root_node_scroll_container.get_child(0)

	add_root_node_header = add_root_node_vbox.get_child(0)
	add_root_node_buttons = add_root_node_scroll_container_vbox.get_child(0)

	add_root_node_2d_button = add_root_node_buttons.get_child(0)
	add_root_node_3d_button = add_root_node_buttons.get_child(1)
	add_root_node_ui_button = add_root_node_buttons.get_child(2)

	add_root_node_other_button = add_root_node_scroll_container_vbox.get_child(2)
	add_root_node_paste_button = add_root_node_scroll_container_vbox.get_child(3)

	main_scene_tree_editor = main_margin_container.find_child("?SceneTreeEditor*", true, false)

	main_scene_tree = main_scene_tree_editor.find_child("?Tree*", false, false)
	node_popup_menu = scene_tree_dock.find_child("?PopupMenu*", false, false)
	
	is_initialized = true
	
	initialized.emit()

	return true

func _retry_initialize():
	if not _try_initialize():
		return
	
	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	autoload.base.child_entered_tree.disconnect(_retry_initialize)
