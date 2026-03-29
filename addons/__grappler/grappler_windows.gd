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
## Utility helpers for creating and controlling editor windows.
class_name GrapplerWindows
extends Node

## Closes the window that owns the given node.
static func close_window_of_node(node: Node) -> void:
	node.get_window().close_requested.emit()

## Opens a simple AcceptDialog with text and optional title.
static func open_simple_accept_dialog(text: String, title: String = "") -> Window:
	var window = AcceptDialog.new()
	window.title = title
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	window.dialog_text = text
	
	window.close_requested.connect(func():
		window.queue_free()
	)
	
	EditorInterface.get_base_control().add_child(window)
	window.show()
	return window

## Opens a basic window with custom content inside.
static func open_simple_window(title: String, content: Node) -> Window:
	var window = Window.new()
	window.title = title
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	
	window.add_child(content)
	
	window.close_requested.connect(func():
		window.queue_free()
	)
	
	window.size = Vector2i(800, 600)
	EditorInterface.get_base_control().add_child(window)
	return window

## Opens a window containing an Inspector for a given object.
static func open_simple_inspector_window(title: String, object: Object) -> Window:
	var content = EditorInspector.new()
	
	content.edit(object)
	content.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	return open_simple_window(title, content)
