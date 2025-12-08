extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

@export var day_number: int = 7

var _test_file: StringName = "res://challenge_files/day_{0}/test.txt".format([day_number])
var _challenge_file: StringName = "res://challenge_files/day_{0}/challenge.txt".format([day_number])


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(challenge_1_solve)
	day_panel.challenge_2_pressed.connect(challenge_2_solve)


func challenge_1_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var data: Array = _load_data(test)
	var beams: Array = []
	var regex = RegEx.new()
	regex.compile("S")

	var helper = regex.search_all(data[0])
	var num_helper: int = 0
	var total_splits: int = 0 
	for i in helper:
		beams.append(i.get_start())
	
	regex.compile("\\^")
	for line_ind in range(1, len(data)):
		# print("--------------------------")
		# beams = unique_array(beams)
		helper = regex.search_all(data[line_ind])
		for found in helper:
			if beams.has(found.get_start()):
				# print("Found a split at {0}".format([found.get_start()]))
				num_helper = beams.pop_at(beams.find(found.get_start()))
				beams.append(num_helper - 1)
				beams.append(num_helper + 1)
				total_splits += 1
	# 	print(total_splits)
	# print(total_splits)
	print("Total splits.: {0}".format([total_splits]))
	print("Total beams.: {0}".format([beams.size()]))
	print(beams)
	

	day_panel.update_log_text("Status.: Finished Challenge 1")


func challenge_2_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")
	var data: Array = _load_data(test)
	var data_converted: Array = []
	var helper: Array = []
	var regex = RegEx.new()
	var value_above: int = 0
	regex.compile("S")
	var beam: int = regex.search(data[0]).get_start()
	# var total: int = iterate_beams(beam, 1, data)
	# print(total)
	for line in range(len(data)):
		helper = []
		for pos in range(len(data[line])):
			if data[line][pos] == ".":
				helper.append(0)
			else:
				helper.append(data[line][pos])
		data_converted.append(helper)

	data_converted[1][beam] = 1
	
	for line in range(2, len(data_converted)):
		for pos in range(len(data_converted[line])):
			if str(data_converted[line][pos]) == "^":

				data_converted[line][pos - 1] += data_converted[line - 1][pos]
				data_converted[line][pos + 1] += data_converted[line - 1][pos]
				data_converted[line][pos] = 0
			else:
				data_converted[line][pos] += data_converted[line - 1][pos]

		# print(data_converted[line])
	
	print(data_converted[-1].reduce(func(accum, number): return accum + number, 0))
	day_panel.update_log_text("Status.: Finished Challenge 2")



# UNUSED
func iterate_beams(position, line_index, data_array) -> int:
	# if line_index == data_array.size():
	# 	return 1
	
	var count: int = 0
	for line in range(line_index, len(data_array)):
		if data_array[line][position] == "^":
			# print("Split (left) at pos {0}, index {1}".format([position - 1, line]))
			count += iterate_beams(position - 1, line, data_array)
			# print(count)
			# print("Split (right) at pos {0}, index {1}".format([position + 1, line]))
			count += iterate_beams(position + 1, line, data_array)
			# print(count)
			return count
	return 1





func _load_data(test: bool) -> Array:
	var file: Array
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	return file


func unique_array(arr: Array) -> Array:
	var dict := {}
	for a in arr:
		dict[a] = 1
	return dict.keys()