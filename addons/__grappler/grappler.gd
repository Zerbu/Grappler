@tool
extends EditorPlugin

func _enable_plugin() -> void:
	add_autoload_singleton("GrapplerSceneTreeDock", "grappler_scene_tree_dock.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton("GrapplerSceneTreeDock")
