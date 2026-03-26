@tool
## Provides easy access to all major editor dock containers and panels.
class_name GrapplerDocks
extends Node

## The root horizontal split that contains *everything* (left, middle, right docks)
static var root_dock_split_container: SplitContainer = \
	GrapplerBase.root_vbox.find_child("DockHSplitMain", true, false)

## Vertical split for the first column of left-side docks
static var left_dock_container_1: SplitContainer = \
	root_dock_split_container.find_child("DockVSplitLeftL", true, false)

## Top tab container for left column 1
static var left_dock_1_top_tab_container: TabContainer = \
	left_dock_container_1.get_child(0)

## Bottom tab container for left column 1
static var left_dock_1_bottom_tab_container: TabContainer = \
	left_dock_container_1.get_child(1)

## Vertical split for the second column of left-side docks
static var left_dock_container_2: SplitContainer = \
	root_dock_split_container.find_child("DockVSplitLeftR", true, false)

## Top tab container for left column 2
static var left_dock_2_top_tab_container: TabContainer = \
	left_dock_container_2.get_child(0)

## Bottom tab container for left column 2
static var left_dock_2_bottom_tab_container: TabContainer = \
	left_dock_container_2.get_child(1)

## Vertical split for the first column of right-side docks
static var right_dock_container_1: SplitContainer = \
	root_dock_split_container.find_child("DockVSplitRightL", true, false)

## Top tab container for right column 1
static var right_dock_1_top_tab_container: TabContainer = \
	left_dock_container_1.get_child(0)

## Bottom tab container for right column 1
static var right_dock_1_bottom_tab_container: TabContainer = \
	left_dock_container_1.get_child(1)

## Vertical split for the second column of right-side docks
static var right_dock_container_2: SplitContainer = \
	root_dock_split_container.find_child("DockVSplitRightR")

## Top tab container for right column 2
static var right_dock_2_top_tab_container: TabContainer = \
	left_dock_container_2.get_child(0)

## Bottom tab container for right column 2
static var right_dock_2_bottom_tab_container: TabContainer = \
	left_dock_container_2.get_child(1)

## The VBox that wraps the center editor area (main editor + bottom panel)
static var middle_vbox: VBoxContainer = \
	root_dock_split_container.find_child("?VBoxContainer*", false, false)

## Vertical split inside the middle area (main editor + bottom panel)
static var middle_split_container: SplitContainer = \
	middle_vbox.find_child("DockVSplitCenter", true, false)

## Split between main editor and bottom panel
static var main_dock_split_container: VSplitContainer = \
	middle_split_container.get_child(0)

## VBox holding tabs + main editor view
static var main_dock_vbox: VBoxContainer = \
	main_dock_split_container.get_child(0)

## Scene tabs (top bar with open scenes)
static var main_dock_scene_tabs: Node = \
	main_dock_vbox.get_child(0)

## The main content area (containing 2D, 3D, Script, or whatever is selected)
static var main_dock_main_screen: Node = \
	main_dock_vbox.get_child(1)

## 2D + UI editor
static var node_2d_and_ui_editor: BoxContainer = \
	main_dock_main_screen.find_child("?CanvasItemEditor*", true, false)

## 3D editor
static var node_3d_editor: BoxContainer = \
	main_dock_main_screen.find_child("?Node3DEditor*", true, false)

## Script editor
static var script_editor: ScriptEditor = \
	main_dock_main_screen.find_child("?ScriptEditor*", true, false)

## Game preview
static var game_view: BoxContainer = \
	main_dock_main_screen.find_child("?GameView*", true, false)

## Asset Library panel
static var asset_library: Control = \
	main_dock_main_screen.find_child("?EditorAssetLibrary*", true, false)

## Tab container for all bottom panel tabs
static var bottom_panel: TabContainer = \
	main_dock_split_container.find_child("EditorBottomPanel", true, false)
