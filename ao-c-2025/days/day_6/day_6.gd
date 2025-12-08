extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

@export var day_number: int = 6

var _test_file: StringName = "res://challenge_files/day_{0}/test.txt".format([day_number])
var _challenge_file: StringName = "res://challenge_files/day_{0}/challenge.txt".format([day_number])


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(challenge_1_solve)
	day_panel.challenge_2_pressed.connect(challenge_2_solve)



func challenge_1_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var data = _load_data(test)
	var size: int = len(data[0])
	var value: int
	var helper: Array = []
	var total: int = 0
	for i in range(0, size):
		value = 0
		helper = []
		for j in range(0, len(data)):
			if str(data[j][i]) == "*":
				value = helper[0]
				for number in range(1, len(helper)):
					value *= helper[number]
			elif str(data[j][i]) == "+":
				value = helper[0]
				for number in range(1, len(helper)):
					value += helper[number]
			else:
				helper.append(data[j][i])
		total += value
	print(total)
	day_panel.update_log_text("Status.: Finished Challenge 1")


func challenge_2_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")
	var data = _load_data_challenge_2(test)
	var equations: Array = data.pop_front()
	var data_dict: Dictionary
	var count: int = 0
	var reversed_data: String
	var equation_result: int = 0
	var total: int = 0

	for i in range(len(equations)):
		count = 0
		data_dict = {}
		equation_result = 0
		for j in data[0][i]:
			data_dict[count] = ""
			count += 1

		for line in data:
			reversed_data = line[i]
			reversed_data.reverse()
			for key in data_dict.keys():
				data_dict[key] += line[i][key]

		for key in data_dict.keys():
			data_dict[key] = int(data_dict[key])
		
		# print(data_dict)
		if equations[i] == "*":
			equation_result = 1
			for key in data_dict.keys():
				if data_dict[key] == 0: continue
				equation_result *= data_dict[key]
		else:
			for key in data_dict.keys():
				equation_result += data_dict[key]
		# print(equation_result)
		total += equation_result
	print(total)

	day_panel.update_log_text("Status.: Finished Challenge 2")


func _load_data_challenge_2(test: bool) -> Array:
	var output: Array = []
	var spacing: Array = []
	var file: Array
	var regex = RegEx.new()
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)

	var regex_matches
	var array_concats: Array
	var last_line: String = file.pop_back()
	
	regex.compile("((\\*|\\+) +)")
	regex_matches = regex.search_all(last_line)
	array_concats = []
	for item in regex_matches:
		array_concats.append(item.get_string()[0])
		spacing.append(len(item.get_string()))

	output.append(array_concats)

	var previous_pos: int = 0
	for item in file:
		array_concats = []
		previous_pos = 0
		for space in spacing:
			array_concats.append(item.substr(previous_pos, space))
			previous_pos += space
		output.append(array_concats)
	return output



func _load_data(test: bool) -> Array:
	var output: Array = []
	var file: Array
	var regex = RegEx.new()
	regex.compile("\\d+")
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	
	var helper
	var line: Array
	for i in file:
		line = []
		helper = regex.search_all(i)
		if helper.size() > 0:
			for item in helper:
				line.append(int(item.get_string()))
		else:
			regex.compile("(\\*|\\+)+")
			helper = regex.search_all(i)
			for item in helper:
				line.append(item.get_string())
		output.append(line)
	return output

	