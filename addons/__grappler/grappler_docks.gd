@tool
## Provides easy access to all major editor dock containers and panels.
extends Node

## Emitted when the helper class is initialized
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
signal initialized

## Whether or not the helper class is initialized
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var is_initialized: bool = false


## The root horizontal split that contains *everything* (left, middle, right docks)
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var root_dock_split_container: SplitContainer

## Vertical split for the first column of left-side docks
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var left_dock_container_1: SplitContainer

## Top tab container for left column 1
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var left_dock_1_top_tab_container: TabContainer

## Bottom tab container for left column 1
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var left_dock_1_bottom_tab_container: TabContainer

## Vertical split for the second column of left-side docks
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var left_dock_container_2: SplitContainer

## Top tab container for left column 2
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var left_dock_2_top_tab_container: TabContainer

## Bottom tab container for left column 2
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var left_dock_2_bottom_tab_container: TabContainer

## Vertical split for the first column of right-side docks
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var right_dock_container_1: SplitContainer

## Top tab container for right column 1
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var right_dock_1_top_tab_container: TabContainer

## Bottom tab container for right column 1
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var right_dock_1_bottom_tab_container: TabContainer

## Vertical split for the second column of right-side docks
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var right_dock_container_2: SplitContainer

## Top tab container for right column 2
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var right_dock_2_top_tab_container: TabContainer

## Bottom tab container for right column 2
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var right_dock_2_bottom_tab_container: TabContainer

## The VBox that wraps the center editor area (main editor + bottom panel)
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var middle_vbox: VBoxContainer

## Vertical split inside the middle area (main editor + bottom panel)
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var middle_split_container: SplitContainer

## Split between main editor and bottom panel
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var main_dock_split_container: VSplitContainer

## VBox holding tabs + main editor view
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var main_dock_vbox: VBoxContainer

## Scene tabs (top bar with open scenes)
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var main_dock_scene_tabs: Node

## The main content area (containing 2D, 3D, Script, or whatever is selected)
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var main_dock_main_screen: Node

## 2D + UI editor
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var node_2d_and_ui_editor: BoxContainer

## 3D editor
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var node_3d_editor: BoxContainer

## Script editor
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var script_editor: ScriptEditor

## Game preview
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var game_view: BoxContainer

## Asset Library panel
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var asset_library: Control

## Tab container for all bottom panel tabs
##
## Note: When accessing members in [class GrapplerDocks], it is
## recommended you do so from inside [method when_initialized].
var bottom_panel: TabContainer

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
	root_dock_split_container = autoload.root_vbox.find_child("DockHSplitMain", true, false)
	if root_dock_split_container == null:
		
		autoload.root_vbox.child_entered_tree.connect(_retry_initialize)
		return false

	left_dock_container_1 = root_dock_split_container.find_child("DockVSplitLeftL", true, false)
	left_dock_1_top_tab_container = left_dock_container_1.get_child(0)
	left_dock_1_bottom_tab_container = left_dock_container_1.get_child(1)

	left_dock_container_2 = root_dock_split_container.find_child("DockVSplitLeftR", true, false)
	left_dock_2_top_tab_container = left_dock_container_2.get_child(0)
	left_dock_2_bottom_tab_container = left_dock_container_2.get_child(1)

	right_dock_container_1 = root_dock_split_container.find_child("DockVSplitRightL", true, false)
	right_dock_1_top_tab_container = right_dock_container_1.get_child(0)
	right_dock_1_bottom_tab_container = right_dock_container_1.get_child(1)

	right_dock_container_2 = root_dock_split_container.find_child("DockVSplitRightR", true, false)
	right_dock_2_top_tab_container = right_dock_container_2.get_child(0)
	right_dock_2_bottom_tab_container = right_dock_container_2.get_child(1)

	middle_vbox = root_dock_split_container.find_child("?VBoxContainer*", false, false)
	middle_split_container = middle_vbox.find_child("DockVSplitCenter", true, false)

	main_dock_split_container = middle_split_container.get_child(0)
	main_dock_vbox = main_dock_split_container.get_child(0)

	main_dock_scene_tabs = main_dock_vbox.get_child(0)
	main_dock_main_screen = main_dock_vbox.get_child(1)

	node_2d_and_ui_editor = main_dock_main_screen.find_child("?CanvasItemEditor*", true, false)
	node_3d_editor = main_dock_main_screen.find_child("?Node3DEditor*", true, false)
	script_editor = main_dock_main_screen.find_child("?ScriptEditor*", true, false)
	game_view = main_dock_main_screen.find_child("?GameView*", true, false)
	asset_library = main_dock_main_screen.find_child("?EditorAssetLibrary*", true, false)

	bottom_panel = middle_split_container.find_child("?EditorBottomPanel*", true, false)

	is_initialized = true
	initialized.emit()

	return true

func _retry_initialize():
	if not _try_initialize():
		return
	
	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	autoload.root_vbox.child_entered_tree.disconnect(_retry_initialize)
