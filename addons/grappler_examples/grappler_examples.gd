@tool
extends EditorPlugin

static var ADDON_PATH: String

var example_menu: PopupMenu

var title_bar_button: Button
var run_bar_button: Button

func _enter_tree() -> void:
	ADDON_PATH = get_script().resource_path.get_base_dir()
	
	example_menu = load("%s/example_menu.tscn" % [
		ADDON_PATH
	]).instantiate()
	
	GrapplerTitleBar.when_initialized(func():
		GrapplerTitleBar.add_to_main_menu(example_menu)
		
		run_bar_button = Button.new()
		run_bar_button.text = "Example Run Bar Button"
		run_bar_button.pressed.connect(func():
			GrapplerWindows.open_simple_accept_dialog(
				"This button was added with: " +
				"GrapplerTitleBar.add_to_run_bar")
		)
		GrapplerTitleBar.add_to_run_bar(run_bar_button)
		
		GrapplerFileSystem.split_filter_files_line_edit.hide()
	)

func _exit_tree() -> void:
	if not GrapplerTitleBar.is_initialized:
		return

	GrapplerTitleBar.remove_from_main_menu(example_menu)
	GrapplerTitleBar.remove_from_title_bar(title_bar_button)
	GrapplerTitleBar.remove_from_run_bar(run_bar_button)
