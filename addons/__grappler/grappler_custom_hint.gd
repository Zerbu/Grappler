## This class converts a hint string defined with @export_custom and converts
## it into an easy to use object.
##
## The format of the string is:
## category/action:param1=value,param2=anothervalue
##
## "category" is usually the name of your plugin, and "action" is used to
## define what kind of action your plugin should perform.
##
## Since @export_custom only supports constant expressions, this class can only
## be used to parse hint strings, not create them. Strings must be written
## manually in the format mentioned above.
class_name GrapplerCustomHint
extends RefCounted

var category: String
var action: String
var params: Dictionary

static func from_string(str: String) -> GrapplerCustomHint:
	var result = GrapplerCustomHint.new()
	
	var category_and_action = str.split("/")[1]
	result.category = category_and_action[0]
	
	var action_and_params = category_and_action.split(':')
	result.action = action_and_params[0]
	if action_and_params.size() <= 1:
		return result
		
	result.params = {}
	for param_key_and_value in action_and_params[1].split(","):
		var param_key_and_value_split = param_key_and_value.split("=")
		var param_key = param_key_and_value_split[0]
		var param_value = param_key_and_value_split[1]
		result.params[param_key] = param_value

	return result

static func is_in_category(str: String, category: String) -> bool:
	return str.begins_with(category+"/")
