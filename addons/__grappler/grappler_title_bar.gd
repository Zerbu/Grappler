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
## Provides access and utilities for the editor's top title bar.
extends Node

## Emitted when the helper class is initialized
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
## This ensures your plugin will work even if the editor UI
## has not finished building yet.
signal initialized

## [constant true] if the helper class is initialized,
## [constant false] otherwise.
var is_initialized: bool = false

## The title bar at the top of the editor.
## It contains the main menu, main screen buttons, and run bar.
var title_bar:					BoxContainer

## The menu bar (containing Scene, Project, etc)
var menu_bar:					MenuBar

## The menu bar's "Scene" menu
var scene_menu:					PopupMenu

## The menu bar's "Project" menu
var project_menu:				PopupMenu

## The menu bar's "Debug" menu
var debug_menu:					PopupMenu

## The menu bar's "Editor" menu
var editor_menu:				PopupMenu

## The menu bar's "Help" menu
var help_menu:					PopupMenu

## The "Editor Docks" menu.
## Located at Editor > Editor Docks
var editor_docks_menu:			PopupMenu

## The "Editor Layouts" menu.
## Located at Editor > Editor Layouts
var editor_layouts_menu:		PopupMenu

## The container holding the main screen buttons (2D, Script, etc)
var main_screen_buttons:		BoxContainer

## The main "2D" button at the top of the editor.
var button_2d:					Button

## The main "3D" button at the top of the editor.
var button_3d:					Button

## The main "Script" button at the top of the editor.
var script_button:				Button

## The main "Game" button at the top of the editor.
var game_button:				Button

## The main "AssetLib" button at the top of the editor.
var asset_lib_button:			Button

## The run bar, containing the "Run Project" button and others.
var run_bar:					Control

## The HBox containing all the [member run_bar] buttons.
var run_bar_buttons:			HBoxContainer

## The run bar's "Run Project" button.
var run_project_button:			Button

## The run bar's "Pause Project" button.
## Visible when the project is running.
var pause_project_button:		Button

## The run bar's "Stop Project" button.
## Visible when the project is running.
var stop_project_button:		Button

## The run bar's "Remote Deploy" container.
var remote_deploy_menu:			BoxContainer

## The run bar's "Run Current Scene" button.
var run_current_scene_button:	Button

## The run bar's "Run Specific Scene" button.
var run_specific_scene_button:	Button

## The run bar's "Movie Maker" menu.
var movie_maker_menu:			PanelContainer

func _ready() -> void:
	_try_initialize()

## If the helper class is initialized, [param callable] will be called.
## Otherwise, it will be stored and called when [member initialized]
## is emitted.
func when_initialized(callable: Callable):
	if not Engine.is_editor_hint(): return

	if is_initialized:
		callable.call()
		return

	initialized.connect(callable)

## Try to initialize the helper class.
## Returns [constant true] if initialized successfully.
## Returns [constant false] otherwise.
## Always returns [constant false] if not running from the editor.
func _try_initialize() -> bool:
	if not Engine.is_editor_hint():
		return false

	var autoload = get_tree().root.get_node("/root/GrapplerBase")

	title_bar = autoload.base.find_child("?EditorTitleBar*", true, false)

	if title_bar == null:
		autoload.child_entered_tree.connect(_retry_initialize)
		return false

	menu_bar = title_bar.find_child("?MenuBar*", false, false)

	scene_menu = menu_bar.get_child(0)
	project_menu = menu_bar.get_child(1)
	debug_menu = menu_bar.get_child(2)
	editor_menu = menu_bar.get_child(3)
	help_menu = menu_bar.get_child(4)

	editor_docks_menu = editor_menu.get_child(0)
	editor_layouts_menu = editor_menu.get_child(1)

	main_screen_buttons = title_bar.get_node("EditorMainScreenButtons")

	button_2d = main_screen_buttons.get_node("2D")
	button_3d = main_screen_buttons.get_node("3D")
	script_button = main_screen_buttons.get_node("Script")
	game_button = main_screen_buttons.get_node("Game")
	asset_lib_button = main_screen_buttons.get_node("AssetLib")

	run_bar = title_bar.find_child("?EditorRunBar*", false, false)
	if run_bar:
		run_bar = run_bar.get_child(0)

	run_bar_buttons = run_bar.find_child("?PanelContainer*", false, false).get_child(0)

	run_project_button = run_bar_buttons.get_child(0)
	pause_project_button = run_bar_buttons.get_child(1)
	stop_project_button = run_bar_buttons.get_child(2)
	remote_deploy_menu = run_bar_buttons.get_child(3)
	run_current_scene_button = run_bar_buttons.get_child(4)
	run_specific_scene_button = run_bar_buttons.get_child(5)
	movie_maker_menu = run_bar_buttons.get_child(6)

	is_initialized = true
	initialized.emit()

	return true

func _retry_initialize():
	if not _try_initialize():
		return
	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	autoload.child_entered_tree.disconnect(_retry_initialize)

## Adds a PopupMenu to the [member menu_bar].
func add_to_main_menu(popup_menu: PopupMenu) -> void:
	popup_menu.hide() # Prevent flashing when added 👀
	menu_bar.add_child(popup_menu)
	
## Removes a PopupMenu from the [member menu_bar].
func remove_from_main_menu(popup_menu: PopupMenu) -> void:
	menu_bar.remove_child(popup_menu)

## Adds a control to [member main_screen_buttons].
func add_to_main_screen_buttons(control: Control) -> void:
	main_screen_buttons.add_child(control)

## Removes a control from [member main_screen_buttons].
func remove_from_main_screen_buttons(control: Control) -> void:
	main_screen_buttons.remove_child(control)

## Switches the main editor screen using text.
##
## Example inputs: "2D", "3D", "Script", "Game", "AssetLib"
func set_main_screen_from_string(text: String) -> void:
	var button = main_screen_buttons.get_node_or_null(text)
	
	if not button:
		button = GrapplerButtonUtils.get_button_by_text(
			main_screen_buttons, text)
	
	if not button:
		return

	GrapplerButtonUtils.simulate_press(button)

## Adds a control to [member run_bar].
func add_to_run_bar(control: Control, index: int = -1) -> void:
	run_bar.add_child(control)
	run_bar.move_child(control, index)

## Removes a control from [member run_bar].
func remove_from_run_bar(control: Control) -> void:
	run_bar.remove_child(control)
