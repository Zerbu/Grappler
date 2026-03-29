'''
MIT License

Copyright (c) 2026 Zerbu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'''

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
