@tool
extends EditorPlugin

var example_menu = load(
	"res://addons/grappler_examples/example_menu.tscn").instantiate()

var title_bar_button: Button
var run_bar_button: Button

func _enter_tree() -> void:
	GrapplerTitleBar.add_to_main_menu(example_menu)
	
	title_bar_button = Button.new()
	title_bar_button.text = "Example Title Bar Button"
	title_bar_button.pressed.connect(func():
		GrapplerWindows.open_simple_accept_dialog(
			"This button was added with: " +
			"GrapplerTitleBar.add_to_title_bar")
	)
	GrapplerTitleBar.add_to_title_bar(title_bar_button)
	
	run_bar_button = Button.new()
	run_bar_button.text = "Example Run Bar Button"
	run_bar_button.pressed.connect(func():
		GrapplerWindows.open_simple_accept_dialog(
			"This button was added with: " +
			"GrapplerTitleBar.add_to_run_bar")
	)
	GrapplerTitleBar.add_to_run_bar(run_bar_button)
	
	GrapplerFileSystem.split_filter_files_line_edit.hide()

func _exit_tree() -> void:
	GrapplerTitleBar.remove_from_main_menu(example_menu)
	GrapplerTitleBar.remove_from_title_bar(title_bar_button)
	GrapplerTitleBar.remove_from_run_bar(run_bar_button)
