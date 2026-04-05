class_name GrapplerItemListUtils
extends Node

static func filter_experimental(item_list: ItemList, include: Callable) -> void:
	for i in item_list.get_item_count():
		var visible := include.call(i)

		if not visible:
			item_list.set_item_disabled(i, not visible)
