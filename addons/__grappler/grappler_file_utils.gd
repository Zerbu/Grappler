class_name GrapplerFileUtils
extends Object

static func get_files_in_directory(dir_path: String, extension: String) -> Array[String]:
	var results: Array[String] = []

	if not DirAccess.dir_exists_absolute(dir_path):
		return results

	var dir := DirAccess.open(dir_path)
	if dir == null:
		return results

	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		var full_path := dir_path.path_join(file_name)

		if dir.current_is_dir():
			if file_name != "." and file_name != "..":
				results += get_files_in_directory(full_path, extension)
		else:
			if extension == "" or file_name.get_extension() == extension:
				results.append(full_path)

		file_name = dir.get_next()

	dir.list_dir_end()
	return results
