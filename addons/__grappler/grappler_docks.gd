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
## Provides structured access to all major editor dock containers and panels.
extends Node

## Emitted when the helper class is initialized.
signal initialized

## [constant true] if the helper class is initialized,
## [constant false] otherwise.
var is_initialized: bool = false

## [constant true] if using a Godot version with bottom docks (4.7+).
## [constant false] otherwise.
var has_bottom_docks:
	get:
		if not has_bottom_docks:
			var version_info = Engine.get_version_info()
			has_bottom_docks = version_info["major"] >= 4 and version_info["minor"] >= 7
		return has_bottom_docks

## The topmost vertical split that contains all docks.
## (Godot 4.7+ Only)
var root_dock_vertical_split_container: SplitContainer

## The topmost horizontal split that contains most docks.
## This excludes the bottom docks ae with 4.7+.
## (left, middle, right docks)
var root_dock_horizontal_split_container: SplitContainer

## Vertical split for the first column of left-side docks.
var left_dock_container_1: SplitContainer

## Top tab container for left column 1.
var left_dock_1_top_tab_container: TabContainer

## Bottom tab container for left column 1.
var left_dock_1_bottom_tab_container: TabContainer

## Vertical split for the second column of left-side docks.
var left_dock_container_2: SplitContainer

## Top tab container for left column 2.
var left_dock_2_top_tab_container: TabContainer

## Bottom tab container for left column 2.
var left_dock_2_bottom_tab_container: TabContainer

## Vertical split for the first column of right-side docks.
var right_dock_container_1: SplitContainer

## Top tab container for right column 1.
var right_dock_1_top_tab_container: TabContainer

## Bottom tab container for right column 1.
var right_dock_1_bottom_tab_container: TabContainer

## Vertical split for the second column of right-side docks.
var right_dock_container_2: SplitContainer

## Top tab container for right column 2.
var right_dock_2_top_tab_container: TabContainer

## Bottom tab container for right column 2.
var right_dock_2_bottom_tab_container: TabContainer

## The VBox that wraps the center editor area (main editor + bottom panel)
var middle_vbox: VBoxContainer

## The vertical split inside the middle area (main editor + bottom panel)
var middle_split_container: SplitContainer

## The split between main editor and bottom panel
var main_dock_split_container: VSplitContainer

## The VBox holding the main editor view an scene tabs.
var main_dock_vbox: VBoxContainer

## Scene tabs (top bar with open scenes)
var main_dock_scene_tabs: Node

## The TabContainer for the scene tabs.
var main_dock_scene_tabs_bar: TabBar

## The main content area (2D, 3D, Script, or whatever is selected)
var main_dock_main_screen: Node

## The main "2D" editor.
var node_2d_and_ui_editor: BoxContainer

## The main "3D" editor.
var node_3d_editor: BoxContainer

## The main "Script" editor.
var script_editor: ScriptEditor

## The main "Game" view.
var game_view: BoxContainer

## The main "AssetLib" view.
var asset_library: Control

## The tab container at the bottom.
## It contains Output, Debugger, Audio, Animation and various others.
var bottom_panel: TabContainer

## The "Output" dock.
var output_dock: EditorDock

## The "Debugger" dock.
var debugger_dock: EditorDock

## The "Audio" dock.
var audio_dock: EditorDock

## The "Animation" dock.
var animation_dock: EditorDock

## The "Shader Editor" dock.
var shader_editor_dock: EditorDock

## Vertical split for the docks at the bottom of the editor.
## (Godot 4.7+ Only)
var bottom_dock_container: SplitContainer

## Left tab container for bottom docks.
var bottom_dock_left_tab_container: TabContainer

## Right tab container for bottom docks.
var bottom_dock_right_tab_container: TabContainer

## The topmost horizontal split that contains everything.
## (left, middle, right docks)
var bottom_dock_split_container: SplitContainer

func _ready() -> void:
	_try_initialize()

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

## Try to initialize the helper class.
## Returns [constant true] if initialized successfully.
## Returns [constant false] otherwise.
## Always returns [constant false] if not running from the editor.
func _try_initialize() -> bool:
	if not Engine.is_editor_hint():
		return false
	
	var version_info = Engine.get_version_info()

	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	
	# Note: Vertical split was added in Godot 4.7.
	# This uses horizontal split instead to continue working in older versions.
	root_dock_horizontal_split_container = autoload.root_vbox.find_child("DockHSplitMain", true, false)
	if root_dock_horizontal_split_container == null:
		autoload.root_vbox.child_entered_tree.connect(_retry_initialize)
		return false

	if has_bottom_docks:
		root_dock_vertical_split_container = autoload.root_vbox.find_child("DockVSplitMain", true, false)

	left_dock_container_1 = root_dock_horizontal_split_container.find_child("DockVSplitLeftL", true, false)
	left_dock_1_top_tab_container = left_dock_container_1.get_child(0)
	left_dock_1_bottom_tab_container = left_dock_container_1.get_child(1)

	left_dock_container_2 = root_dock_horizontal_split_container.find_child("DockVSplitLeftR", true, false)
	left_dock_2_top_tab_container = left_dock_container_2.get_child(0)
	left_dock_2_bottom_tab_container = left_dock_container_2.get_child(1)

	right_dock_container_1 = root_dock_horizontal_split_container.find_child("DockVSplitRightL", true, false)
	right_dock_1_top_tab_container = right_dock_container_1.get_child(0)
	right_dock_1_bottom_tab_container = right_dock_container_1.get_child(1)

	right_dock_container_2 = root_dock_horizontal_split_container.find_child("DockVSplitRightR", true, false)
	right_dock_2_top_tab_container = right_dock_container_2.get_child(0)
	right_dock_2_bottom_tab_container = right_dock_container_2.get_child(1)

	middle_vbox = root_dock_horizontal_split_container.find_child("?VBoxContainer*", false, false)
	middle_split_container = middle_vbox.find_child("DockVSplitCenter", true, false)

	main_dock_split_container = middle_split_container.get_child(0)
	main_dock_vbox = main_dock_split_container.get_child(0)

	main_dock_scene_tabs = main_dock_vbox.get_child(0)
	main_dock_scene_tabs_bar = main_dock_scene_tabs.find_child("?TabBar*", true, false)
	main_dock_main_screen = main_dock_vbox.get_child(1)

	node_2d_and_ui_editor = main_dock_main_screen.find_child("?CanvasItemEditor*", true, false)
	node_3d_editor = main_dock_main_screen.find_child("?Node3DEditor*", true, false)
	script_editor = main_dock_main_screen.find_child("?ScriptEditor*", true, false)
	game_view = main_dock_main_screen.find_child("?GameView*", true, false)
	asset_library = main_dock_main_screen.find_child("?EditorAssetLibrary*", true, false)

	bottom_panel = middle_split_container.find_child("?EditorBottomPanel*", true, false)

	output_dock = bottom_panel.find_child("Output", false, false)
	debugger_dock = bottom_panel.find_child("Debugger", false, false)
	audio_dock = bottom_panel.find_child("AudioBuses", false, false)
	animation_dock = bottom_panel.find_child("Animation", false, false)
	shader_editor_dock = bottom_panel.find_child("Shader Editor", false, false)

	if has_bottom_docks:
		bottom_dock_container = root_dock_vertical_split_container.find_child("DockHSplitBottom", true, false)
		bottom_dock_left_tab_container = bottom_dock_container.get_child(0)
		bottom_dock_right_tab_container = bottom_dock_container.get_child(1)

	is_initialized = true
	initialized.emit()

	return true

func _retry_initialize():
	if not _try_initialize(): return
	
	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	autoload.root_vbox.child_entered_tree.disconnect(_retry_initialize)
