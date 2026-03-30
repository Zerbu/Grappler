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

class_name GrapplerTreeUtils
extends Node

enum FilterResult
{
	INCLUDE,
	EXCLUDE,
	EXCLUDE_TREE
}

static func filter(root: TreeItem, include: Callable) -> void:
	_filter_recursive(root, include)

static func _filter_recursive(item: TreeItem, include: Callable) -> bool:
	if not item.visible:
		return false
	
	var any_child_visible = false

	var visible = include.call(item)

	if not visible:
		var child = item.get_first_child()
		while child:
			var child_visible = _filter_recursive(child, include)
			if not visible:
				visible = child_visible
			child = child.get_next()

	item.set_visible(visible)

	return visible
