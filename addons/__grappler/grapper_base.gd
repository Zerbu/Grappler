@tool
class_name GrapplerBase
extends Node

## The editor base control. This is identical to calling
## [method EditorInterface.get_base_control]
static var base: Control = EditorInterface.get_base_control()

## The VBox containing everything in the main Godot editor, starting with the
## title bar.
static var root_vbox: Control = base.get_child(0)
