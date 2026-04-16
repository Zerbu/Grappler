extends EditorInspectorPlugin

func _can_handle(object):
	return true

func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide) -> bool:
	if object.has_method("_grappler_parse_property"):
		return object._grappler_parse_property(self, type, name, hint_type, hint_string, usage_flags, wide)
	if object.has_method("_grappler_parse_property_simple"):
		return object._grappler_parse_property_simple(self, name)
	return false

func _parse_begin(object: Object) -> void:
	if object.has_method("_grappler_parse_begin"):
		object._grappler_parse_begin(self)

func _parse_end(object: Object) -> void:
	if object.has_method("_grappler_parse_end"):
		object._grappler_parse_end(self)

func _parse_category(object: Object, category: String) -> void:
	if object.has_method("_grappler_parse_category"):
		object._grappler_parse_category(self, category)

func _parse_group(object: Object, group: String) -> void:
	if object.has_method("_grappler_parse_group"):
		object._grappler_parse_group(self, group)
