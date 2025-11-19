class_name FileHandler
extends Node

signal error_file_not_found()


func load_file_string(filepath: String) -> String:
	var output: String = ""
	if FileAccess.file_exists(filepath):
		var file = FileAccess.open(filepath, FileAccess.READ)
		output = file.get_as_text()
	else:
		error_file_not_found.emit()
	return output


func load_file_array(filepath: String) -> Array:
	var output: Array = []
	if FileAccess.file_exists(filepath):
		var file = FileAccess.open(filepath, FileAccess.READ)
		while not file.eof_reached(): output.append(file.get_line())
		output.pop_back()
	else:
		error_file_not_found.emit()
	return output