## Utility helpers for working with Button nodes in the editor.
class_name GrapplerButtons
extends Node

## Searches direct children of a node for a Button with matching text.
##
## [param parent]: The node whose direct children will be searched.
## [param text]: The text to match against each Button's `text` property.
static func get_button_by_text(parent: Node, text: String) -> Button:
	for child: Node in parent.get_children():
		if child is Button:
			var button := child as Button
			if button.text == text:
				return button
	
	return null

## Simulates a button press by emitting its `pressed` signal.
##
## [param button]: The Button to simulate a press on.
static func simulate_press(button: Button) -> void:
	button.pressed.emit()
