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

## Whether or not the helper class is initialized
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
## This ensures your plugin will work even if the editor UI
## has not finished building yet.
var is_initialized: bool = false

## Root title bar container at the top of the editor
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var title_bar: BoxContainer

## Top menu bar container
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var main_menu: MenuBar

## Scene menu (scene operations)
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var scene_menu: PopupMenu

## Project menu (project settings, export, etc.)
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var project_menu: PopupMenu

## Debug menu (debugging tools)
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var debug_menu: PopupMenu

## Editor menu (layout, docks, editor settings)
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var editor_menu: PopupMenu

## Help menu (docs, about, etc.)
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var help_menu: PopupMenu

## Menu for showing/hiding docks
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var editor_docks_menu: PopupMenu

## Menu for saving/loading editor layouts
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var editor_layouts_menu: PopupMenu

## Container holding main editor mode buttons
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var main_screen_buttons: BoxContainer

## Switch to 2D editor
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var button_2d: Button

## Switch to 3D editor
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var button_3d: Button

## Switch to Script editor
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var script_button: Button

## Switch to Game view (running scene)
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var game_button: Button

## Switch to Asset Library
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var asset_lib_button: Button

## Container holding run controls
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var run_bar: HBoxContainer

## Inner container for run buttons
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var run_bar_buttons: HBoxContainer

## Run the entire project
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var run_project_button: Button

## Pause the running project
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var pause_project_button: Button

## Stop the running project
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var stop_project_button: Button

## Remote deploy options (devices, etc.)
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var remote_deploy_menu: BoxContainer

## Run currently open scene
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var run_current_scene_button: Button

## Run a specific scene
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var run_specific_scene_button: Button

## Movie maker / capture tools
##
## Note: When accessing members in [class GrapplerTitleBar], it is
## recommended you do so from inside [method when_initialized].
var movie_maker_menu: PanelContainer


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


func _ready() -> void:
	_try_initialize()


func _try_initialize() -> bool:
	if not Engine.is_editor_hint():
		return false

	var autoload = get_tree().root.get_node("/root/GrapplerBase")

	title_bar = autoload.find_child("?EditorTitleBar*", true, false)
	if title_bar == null:
		autoload.child_entered_tree.connect(_retry_initialize)
		return false

	main_menu = title_bar.find_child("?MenuBar*", false, false)

	scene_menu = main_menu.get_child(0)
	project_menu = main_menu.get_child(1)
	debug_menu = main_menu.get_child(2)
	editor_menu = main_menu.get_child(3)
	help_menu = main_menu.get_child(4)

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

## Adds a PopupMenu to the main menu bar
func add_to_main_menu(popup_menu: PopupMenu) -> void:
	popup_menu.hide() # Prevent flashing when added 👀
	main_menu.add_child(popup_menu)
	
## Removes a PopupMenu from the main menu bar
func remove_from_main_menu(popup_menu: PopupMenu) -> void:
	main_menu.remove_child(popup_menu)

## Adds a control to the main screen button row
func add_to_main_screen_buttons(control: Control) -> void:
	main_screen_buttons.add_child(control)

## Removes a control from the main screen button row
func remove_from_main_screen_buttons(control: Control) -> void:
	main_screen_buttons.remove_child(control)

## Switches editor screen using a button name or text
##
## Example inputs: "2D", "3D", "Script", "Game", "AssetLib"
func set_main_screen_from_string(text: String) -> void:
	var button = main_screen_buttons.get_node_or_null(text)
	
	if not button:
		button = GrapplerButtons.get_button_by_text(main_screen_buttons, text)
	
	if not button:
		return
	
	# Simulate pressing the button
	GrapplerButtons.simulate_press(button)

## Adds a control to the run bar at a specific position
func add_to_run_bar(control: Control, index: int = -1) -> void:
	run_bar.add_child(control)
	run_bar.move_child(control, index)

## Removes a control from the run bar
func remove_from_run_bar(control: Control) -> void:
	run_bar.remove_child(control)

## Adds a control anywhere on the title bar
func add_to_title_bar(control: Control, index: int = -1) -> void:
	title_bar.add_child(control)
	title_bar.move_child(control, index)

## Removes a control from the title bar
func remove_from_title_bar(control: Control) -> void:
	title_bar.remove_child(control)
