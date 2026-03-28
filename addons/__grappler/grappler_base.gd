@tool
extends Node

## The editor base control. This is identical to calling
## [method EditorInterface.get_base_control]
var base: Control

## The VBox containing everything in the main Godot editor, starting with the
## title bar.
var root_vbox: Control

func _ready() -> void:
	if not Engine.is_editor_hint():
		return
	base = EditorInterface.get_base_control()
	root_vbox = base.get_child(0)
