@tool
## Provides structured access to the Scene Tree dock and its UI elements.
class_name GrapplerSceneTreeDock
extends Node

## Root Scene Tree dock panel
static var scene_tree_dock: EditorDock = \
	GrapplerBase.base.find_child("DockHSplitMain", true, false).find_child("Scene", true, false)

## Main vertical layout of the dock
static var scene_tree_dock_vbox: VBoxContainer = \
	scene_tree_dock.get_child(0)

## Top row containing core scene actions
static var scene_tree_main_header: HBoxContainer = \
	scene_tree_dock_vbox.get_child(0)

## Add child node button (+)
static var add_child_node_button: Button = \
	scene_tree_main_header.get_child(0)

## Instantiate scene button (chain link icon)
static var instantiate_child_scene_button: Button = \
	scene_tree_main_header.get_child(1)

## Filter/search nodes input
static var filter_nodes_line_edit: LineEdit = \
	scene_tree_main_header.get_child(2)

## Attach script button
static var attach_script_button: Button = \
	scene_tree_main_header.get_child(3)

## Remove script button
static var remove_script_button: Button = \
	scene_tree_main_header.get_child(4)

## Change script button
static var change_script_button: Button = \
	scene_tree_main_header.get_child(5)

## Header for switching between local and remote scene trees
static var remote_local_header: HBoxContainer = \
	scene_tree_dock_vbox.get_child(1)

## Switch to remote scene tree (running game)
static var remote_button: Button = \
	scene_tree_main_header.get_child(0)

## Switch to local scene tree (editor scene)
static var local_button: Button = \
	scene_tree_main_header.get_child(1)

## Container holding either "Add Root Node" UI or the scene tree
static var main_margin_container: MarginContainer = \
	scene_tree_dock_vbox.get_child(2)

## Container shown when no root node exists
static var add_root_node_vbox: VBoxContainer = \
	main_margin_container.get_child(0)

## Scroll container for root node options
static var add_root_node_scroll_container: ScrollContainer = \
	add_root_node_vbox.get_child(1)

## Inner layout for scroll content
static var add_root_node_scroll_container_vbox: VBoxContainer = \
	add_root_node_scroll_container.get_child(0)

## Header for the "Add Root Node" menu
static var add_root_node_header: HBoxContainer = \
	add_root_node_vbox.get_child(0)

## Container holding main root node buttons
static var add_root_node_buttons: VBoxContainer = \
	add_root_node_scroll_container_vbox.get_child(0)

## Quick-create 2D root node
static var add_root_node_2d_button: Button = \
	add_root_node_buttons.get_child(0)

## Quick-create 3D root node
static var add_root_node_3d_button: Button = \
	add_root_node_buttons.get_child(1)

## Quick-create UI root node
static var add_root_node_ui_button: Button = \
	add_root_node_buttons.get_child(2)

## "Other Node" button (opens full node list)
static var add_root_node_other_button: Button = \
	add_root_node_scroll_container_vbox.get_child(2)

## Paste node from clipboard
static var add_root_node_paste_button: Button = \
	add_root_node_scroll_container_vbox.get_child(3)

## SceneTreeEditor wrapper control
static var main_scene_tree_editor: Control = \
	main_margin_container.find_child("?SceneTreeEditor*", true, false)

## Actual Tree node displaying hierarchy
static var main_scene_tree: Tree = \
	main_scene_tree_editor.find_child("?Tree*", false, false)

## Right-click menu for nodes in the scene tree
static var node_popup_menu: PopupMenu = \
	scene_tree_dock.find_child("?PopupMenu*", false, false)

## Adds a control to the main header
static func add_to_scene_tree_main_header(control: Control, index: int = -1):
	scene_tree_main_header.add_child(control)
	scene_tree_main_header.move_child(control, index)

## Removes a control from the main header
static func remove_from_scene_tree_main_header(control: Control):
	scene_tree_dock_vbox.remove_child(control)

## Adds a control to the "Add Root Node" button list
static func add_to_root_node_buttons(control: Control, index: int = -1):
	add_root_node_buttons.add_child(control)
	add_root_node_buttons.move_child(control, index)

## Removes a control from the "Add Root Node" buttons
static func remove_from_add_root_node_buttons(control: Control):
	scene_tree_dock_vbox.remove_child(control)
