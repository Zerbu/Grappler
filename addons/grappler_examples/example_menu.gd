@tool
extends PopupMenu

func _on_id_pressed(id: int) -> void:
	GrapplerWindows.open_simple_accept_dialog("This custom menu was added with: " + "GrapplerTitleBar.add_to_main_menu")
