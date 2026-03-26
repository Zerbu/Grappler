@tool
## Provides structured access to the Godot FileSystem dock UI.
class_name GrapplerFileSystem
extends Node

## Root FileSystem dock from the editor
static var filesystem_dock: FileSystemDock = \
	EditorInterface.get_file_system_dock()

## Main vertical container of the dock
static var filesystem_dock_vbox: VBoxContainer = \
	filesystem_dock.get_child(0)

## Container holding all header UI
static var header_vbox: VBoxContainer = \
	filesystem_dock_vbox.get_child(0)

## Horizontal row of main header controls
static var header_hbox: HBoxContainer = \
	header_vbox.get_child(0)

## Container holding back/forward navigation buttons
static var header_back_forward_buttons: HBoxContainer = \
	header_hbox.get_child(0)

## Navigate back in filesystem history
static var back_button: Button = \
	header_back_forward_buttons.get_child(0)

## Navigate forward in filesystem history
static var forward_button: Button = \
	header_back_forward_buttons.get_child(1)

## Path input field (current directory path)
static var path_line_edit: LineEdit = \
	header_hbox.get_child(1)

## Button to toggle split / no-split mode
static var change_split_mode_button: Button = \
	header_hbox.get_child(2)

## Container for filter + sort when not in split mode
static var nosplit_filter_files_hbox: HBoxContainer = \
	header_vbox.get_child(1)

## Text filter for files (no-split mode)
static var nosplit_filter_files_line_edit: LineEdit = \
	nosplit_filter_files_hbox.get_child(0)

## Sort options button (no-split mode)
static var nosplit_sort_files_button: MenuButton = \
	nosplit_filter_files_hbox.get_child(1)

## Main split container
static var main_split_container: SplitContainer = \
	filesystem_dock_vbox.get_child(1)

## Left side container
static var main_margin_container: MarginContainer = \
	main_split_container.get_child(0)

## FileSystem tree
static var main_tree: Tree = \
	main_margin_container.get_child(0)

## Right-side vertical layout (filters + file list)
static var main_split_vbox: VBoxContainer = \
	main_split_container.get_child(1)

## Container for split-mode filtering and controls
static var split_filter_files_hbox: HBoxContainer = \
	main_split_vbox.get_child(0)

## Text filter for files (split mode)
static var split_filter_files_line_edit: LineEdit = \
	split_filter_files_hbox.get_child(0)

## Sort options button (split mode)
static var split_sort_files_button: MenuButton = \
	split_filter_files_hbox.get_child(1)

## Toggle between grid/list view
static var split_view_grid_button: Button = \
	split_filter_files_hbox.get_child(2)

## Container wrapping the file list
static var file_list_margin_container: MarginContainer = \
	main_split_vbox.get_child(1)

## File list displaying files in current directory
static var file_list: ItemList = \
	file_list_margin_container.get_child(0)

## Right-click context menu for filesystem actions
static var popup_menu: PopupMenu = \
	filesystem_dock.get_child(2)
