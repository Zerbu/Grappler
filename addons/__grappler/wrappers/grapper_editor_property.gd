@tool
class_name GrapplerEditorProperty
extends EditorProperty

var _is_updating = false

## Gets the value of the edited property.
func get_value():
	var edited_object = get_edited_object()
	if not edited_object:
		return
	return edited_object.get(get_edited_property())

## Gets the value of the another property on the edited object.
func get_other_value(property_name: String):
	var edited_object = get_edited_object()
	if not edited_object:
		return
	return edited_object.get(property_name)

## Sets the value of the edited property.
func set_value(value: Variant, is_changing: bool = false):
	emit_changed(get_edited_property(), value, "", is_changing)
