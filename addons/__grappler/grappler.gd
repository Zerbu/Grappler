@tool
extends EditorPlugin

func _enable_plugin() -> void:
	add_autoload_singleton("GrapplerBase", "grappler_base.gd")
	add_autoload_singleton("GrapplerDocks", "grappler_docks.gd")
	add_autoload_singleton("GrapplerSceneTreeDock", "grappler_scene_tree_dock.gd")
	add_autoload_singleton("GrapplerTitleBar", "grappler_title_bar.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton("GrapplerBase")
	remove_autoload_singleton("GrapplerDocks")
	remove_autoload_singleton("GrapplerSceneTreeDock")
	remove_autoload_singleton("GrapplerTitleBar")
