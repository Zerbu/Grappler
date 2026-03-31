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
## Provides structured access to the Scene Tree dock and its UI elements.
extends Node

## Emitted when the helper class is initialized.
signal initialized

## [constant true] if the helper class is initialized,
## [constant false] otherwise.
var is_initialized: bool = false

## The signals dock itself.
var signals_dock: EditorDock

## The signal "connections" dock, nested within the signals dock.
var signal_connections_dock: Node

## The main vertical container for the signals dock.
var signals_dock_vbox: VBoxContainer

## The line edit for filtering the signals dock.
var filter_signals_line_edit: LineEdit

# THe main container for the signals tree.
var signals_main_margin_container: MarginContainer

# The signals tree itself.
var signals_tree: Tree

## If the helper class is initialized, the [param callable] parameter
## will be called right away. Otherwise, it will be called when
## [signal initialized] is emitted.
func when_initialized(callable: Callable):
	if not Engine.is_editor_hint():
		return
	if is_initialized:
		callable.call()
		return
	initialized.connect(callable)

func _ready() -> void:
	_try_initialize()

func _try_initialize() -> bool:
	if not Engine.is_editor_hint():
		return false
	
	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	
	var dock_base = autoload.base.find_child("DockHSplitMain", true, false)
	if dock_base == null:
		autoload.base.child_entered_tree.connect(_retry_initialize)
		return false

	var dock = dock_base.find_child("Signals", true, false)

	signals_dock = dock
	signal_connections_dock = signals_dock.get_child(0)
	signals_dock_vbox = signal_connections_dock.get_child(0)
	filter_signals_line_edit = signals_dock_vbox.get_child(0)
	signals_main_margin_container = signals_dock_vbox.get_child(1)
	signals_tree = signals_main_margin_container.get_child(0)
	
	is_initialized = true
	
	initialized.emit()

	return true

func _retry_initialize():
	if not _try_initialize():
		return
	
	var autoload = get_tree().root.get_node("/root/GrapplerBase")
	autoload.base.child_entered_tree.disconnect(_retry_initialize)
