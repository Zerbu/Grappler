@tool
## Provides structured access to the Scene Tree dock and its UI elements.
extends Node

## Emitted when the helper class is initialized
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
signal initialized

## Whether or not the helper class is initialized
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var is_initialized: bool = true

## Root Scene Tree dock panel
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var scene_tree_dock: EditorDock

## Main vertical layout of the dock
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var scene_tree_dock_vbox: VBoxContainer

## Top row containing core scene actions
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var scene_tree_main_header: HBoxContainer

## Add child node button (+)
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_child_node_button: Button

## Instantiate scene button (chain link icon)
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var instantiate_child_scene_button: Button

## Filter/search nodes input
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var filter_nodes_line_edit: LineEdit

## Attach script button
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var attach_script_button: Button

## Remove script button
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var remove_script_button: Button 

## Change script button
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var change_script_button: Button

## Header for switching between local and remote scene trees
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var remote_local_header: HBoxContainer

## Switch to remote scene tree (running game)
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var remote_button: Button

## Switch to local scene tree (editor scene)
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var local_button: Button

## Container holding either "Add Root Node" UI or the scene tree
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var main_margin_container: MarginContainer

## Container shown when no root node exists
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_vbox: VBoxContainer

## Scroll container for root node options
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_scroll_container: ScrollContainer

## Inner layout for scroll content
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_scroll_container_vbox: VBoxContainer

## Header for the "Add Root Node" menu
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_header: HBoxContainer

## Container holding main root node buttons
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_buttons: VBoxContainer

## Quick-create 2D root node
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_2d_button: Button

## Quick-create 3D root node
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_3d_button: Button

## Quick-create UI root node
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_ui_button: Button

## "Other Node" button (opens full node list)
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_other_button: Button

## Paste node from clipboard
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var add_root_node_paste_button: Button

## SceneTreeEditor wrapper control
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var main_scene_tree_editor: Control

## Actual Tree node displaying hierarchy
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var main_scene_tree: Tree

## Right-click menu for nodes in the scene tree
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
var node_popup_menu: PopupMenu

## If the helper class is initialized, the [param callable] parameter
## will be called right away. Otherwise, it will be called when
## [signal initialized] is emitted.
func when_initialized(callable: Callable):
	if is_initialized:
		callable.call()
		return
	initialized.connect(callable)

## Adds a control to the main header
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
func add_to_scene_tree_main_header(control: Control, index: int = -1):
	scene_tree_main_header.add_child(control)
	scene_tree_main_header.move_child(control, index)

## Removes a control from the main header
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
func remove_from_scene_tree_main_header(control: Control):
	scene_tree_dock_vbox.remove_child(control)

## Adds a control to the "Add Root Node" button list
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
func add_to_root_node_buttons(control: Control, index: int = -1):
	add_root_node_buttons.add_child(control)
	add_root_node_buttons.move_child(control, index)

## Removes a control from the "Add Root Node" buttons
##
## Note: When accessing members in [class]GrapplerSceneTreeDock[/class], it is
## recommended you do so from inside [method]when_initialized[/method].
## This ensures your plugin will work even if the project was
## launched with the scene tree dock disabled.
func remove_from_add_root_node_buttons(control: Control):
	scene_tree_dock_vbox.remove_child(control)

func _ready() -> void:
	_try_initialize()

func _try_initialize() -> bool:
	var dock_base = GrapplerBase.base.find_child("DockHSplitMain", true, false)
	if dock_base == null:
		GrapplerBase.base.child_entered_tree.connect(_retry_initialize)
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
	GrapplerBase.base.child_entered_tree.disconnect(_retry_initialize)
