@tool
## Provides access and utilities for the editor's top title bar.
class_name GrapplerTitleBar
extends Node

## Root title bar container at the top of the editor
static var title_bar: BoxContainer = \
	GrapplerBase.base.find_child("?EditorTitleBar*", true, false)

## Top menu bar container
static var main_menu: MenuBar = \
	title_bar.find_child("?MenuBar*", false, false)

## Scene menu (scene operations)
static var scene_menu: PopupMenu = main_menu.get_child(0)

## Project menu (project settings, export, etc.)
static var project_menu: PopupMenu = main_menu.get_child(1)

## Debug menu (debugging tools)
static var debug_menu: PopupMenu = main_menu.get_child(2)

## Editor menu (layout, docks, editor settings)
static var editor_menu: PopupMenu = main_menu.get_child(3)

## Help menu (docs, about, etc.)
static var help_menu: PopupMenu = main_menu.get_child(4)

## Menu for showing/hiding docks
static var editor_docks_menu: PopupMenu = editor_menu.get_child(0)

## Menu for saving/loading editor layouts
static var editor_layouts_menu: PopupMenu = editor_menu.get_child(1)

## Container holding main editor mode buttons
static var main_screen_buttons: BoxContainer = \
	title_bar.get_node("EditorMainScreenButtons")

## Switch to 2D editor
static var button_2d: Button = main_screen_buttons.get_node("2D")

## Switch to 3D editor
static var button_3d: Button = main_screen_buttons.get_node("3D")

## Switch to Script editor
static var script_button: Button = main_screen_buttons.get_node("Script")

## Switch to Game view (running scene)
static var game_button: Button = main_screen_buttons.get_node("Game")

## Switch to Asset Library
static var asset_lib_button: Button = main_screen_buttons.get_node("AssetLib")

## Container holding run controls
static var run_bar: HBoxContainer = \
	title_bar.find_child("?EditorRunBar*", false, false).get_child(0)

## Inner container for run buttons
static var run_bar_buttons: HBoxContainer = \
	run_bar.find_child("?PanelContainer*", false, false).get_child(0)

## Run the entire project
static var run_project_button: Button = run_bar_buttons.get_child(0)

## Pause the running project
static var pause_project_button: Button = run_bar_buttons.get_child(1)

## Stop the running project
static var stop_project_button: Button = run_bar_buttons.get_child(2)

## Remote deploy options (devices, etc.)
static var remote_deploy_menu: BoxContainer = run_bar_buttons.get_child(3)

## Run currently open scene
static var run_current_scene_button: Button = run_bar_buttons.get_child(4)

## Run a specific scene
static var run_specific_scene_button: Button = run_bar_buttons.get_child(5)

## Movie maker / capture tools
static var movie_maker_menu: PanelContainer = run_bar_buttons.get_child(6)

## Adds a PopupMenu to the main menu bar
static func add_to_main_menu(popup_menu: PopupMenu) -> void:
	popup_menu.hide() # Prevent flashing when added 👀
	main_menu.add_child(popup_menu)
	
## Removes a PopupMenu from the main menu bar
static func remove_from_main_menu(popup_menu: PopupMenu) -> void:
	main_menu.remove_child(popup_menu)

## Adds a control to the main screen button row
static func add_to_main_screen_buttons(control: Control) -> void:
	main_screen_buttons.add_child(control)

## Removes a control from the main screen button row
static func remove_from_main_screen_buttons(control: Control) -> void:
	main_screen_buttons.remove_child(control)

## Switches editor screen using a button name or text
##
## Example inputs: "2D", "3D", "Script", "Game", "AssetLib"
static func set_main_screen_from_string(text: String) -> void:
	var button = main_screen_buttons.get_node_or_null(text)
	
	if not button:
		button = GrapplerButtons.get_button_by_text(main_screen_buttons, text)
	
	if not button:
		return
	
	# Simulate pressing the button
	GrapplerButtons.simulate_press(button)

## Adds a control to the run bar at a specific position
static func add_to_run_bar(control: Control, index: int = -1) -> void:
	run_bar.add_child(control)
	run_bar.move_child(control, index)

## Removes a control from the run bar
static func remove_from_run_bar(control: Control) -> void:
	run_bar.remove_child(control)

## Adds a control anywhere on the title bar
static func add_to_title_bar(control: Control, index: int = -1) -> void:
	title_bar.add_child(control)
	title_bar.move_child(control, index)

## Removes a control from the title bar
static func remove_from_title_bar(control: Control) -> void:
	title_bar.remove_child(control)
