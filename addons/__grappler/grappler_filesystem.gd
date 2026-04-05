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
## Provides structured access to the FileSystem dock.
class_name GrapplerFileSystem
extends Node

## The FileSystem dock itself.
## Identical to calling [method EditorInterface.get_file_system_dock()]
static var filesystem_dock: FileSystemDock = \
	EditorInterface.get_file_system_dock()

## The main vertical container of the dock.
static var filesystem_dock_vbox: VBoxContainer = \
	filesystem_dock.get_child(0)

## The main container of the dock holding the forward and back buttons,
## the file path text input, and the "Change Split Mode" button.
static var header_vbox: VBoxContainer = \
	filesystem_dock_vbox.get_child(0)

## The main HBox holding the forward and back buttons,
## the file path text input, and the "Change Split Mode" button.
static var header_hbox: HBoxContainer = \
	header_vbox.get_child(0)

## The HBox containing the forward an back buttons.
static var header_back_forward_buttons: HBoxContainer = \
	header_hbox.get_child(0)

## The FileSystem's "Back" button.
static var back_button: Button = \
	header_back_forward_buttons.get_child(0)

## The FileSystem's "Forward" button.
static var forward_button: Button = \
	header_back_forward_buttons.get_child(1)

## The FileSystem's path line edit.
## It contains the path of the currently selected file or directory.
static var path_line_edit: LineEdit = \
	header_hbox.get_child(1)

## The "Change Split Mode" button.
static var change_split_mode_button: Button = \
	header_hbox.get_child(2)

## The HBox containing the "Filter Files" line edit.
## Only visible when the dock is not in any split mode.
static var nosplit_filter_files_hbox: HBoxContainer = \
	header_vbox.get_child(1)

## The "Filter Files" line edit.
## Only visible when the dock is not in any split mode.
static var nosplit_filter_files_line_edit: LineEdit = \
	nosplit_filter_files_hbox.get_child(0)

## The "Sort Files" button.
## Only visible when the dock is not in any split mode.
static var nosplit_sort_files_button: MenuButton = \
	nosplit_filter_files_hbox.get_child(1)

## The split container seperating options from the file tree itself.
static var main_split_container: SplitContainer = \
	filesystem_dock_vbox.get_child(1)

## The main margin container that contains the file tree.
static var main_margin_container: MarginContainer = \
	main_split_container.get_child(0)

## The file tree itself.
static var main_tree: Tree = \
	main_margin_container.get_child(0)

static var main_split_vbox: VBoxContainer = \
	main_split_container.get_child(1)

static var split_filter_files_hbox: HBoxContainer = \
	main_split_vbox.get_child(0)

## The "Filter Files" line edit.
## Only visible when the dock is split.
static var split_filter_files_line_edit: LineEdit = \
	split_filter_files_hbox.get_child(0)

## The "Sort Files" button.
## Only visible when the dock is split.
static var split_sort_files_button: MenuButton = \
	split_filter_files_hbox.get_child(1)

## The button to toggle between grid and list view.
## Only visible when the dock is split.
static var split_view_grid_button: Button = \
	split_filter_files_hbox.get_child(2)

## The margin container that contains the file list in split mode.
static var file_list_margin_container: MarginContainer = \
	main_split_vbox.get_child(1)

## The file list, not to be confused with the file tree.
## Only visible when the dock is split.
static var file_list: ItemList = \
	file_list_margin_container.get_child(0)

## The right-click context menu for filesystem actions.
static var popup_menu: PopupMenu = \
	filesystem_dock.get_child(2)

static func open_file(path: String):
	if path.get_extension() in ["tscn", "scn"]:
		EditorInterface.open_scene_from_path(path)
		var root = load(path).instantiate()
		if root is Node3D:
			EditorInterface.set_main_screen_editor("3D")
		else:
			EditorInterface.set_main_screen_editor("2D")
	else:
		EditorInterface.edit_resource(load(path))
		if path.get_extension() == ".gd":
			EditorInterface.set_main_screen_editor("Script")
