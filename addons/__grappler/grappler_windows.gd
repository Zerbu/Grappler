@tool
## Utility helpers for creating and controlling editor windows.
class_name GrapplerWindows
extends Node

## Closes the window that owns the given node.
##
## Emits the `close_requested` signal on the window,
## which lets it clean itself up properly.
##
## [param node]: Any node inside the window you want to close.
static func close_window_of_node(node: Node) -> void:
	node.get_window().close_requested.emit()

## Opens a simple AcceptDialog with text and optional title.
##
## [param text]: Message shown inside the dialog.
## [param title]: Window title (optional).
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
##
## [param title]: Window title.
## [param content]: Any Node to display inside the window.
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
##
## [param title]: Window title.
## [param object]: Object to inspect.
##
## Uses EditorInspector to display editable properties.
##
## Returns:
## - The created inspector window.
static func open_simple_inspector_window(title: String, object: Object) -> Window:
	var content = EditorInspector.new()
	
	content.edit(object)
	content.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	return open_simple_window(title, content)
