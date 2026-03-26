@tool
class_name GrapplerInspector
extends EditorInspector

@export var editing_resource: Resource:
	get: return get_edited_object()
	set(value):
		editing_resource = value
		edit(value)
