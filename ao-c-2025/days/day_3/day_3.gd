extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

var _test_file: StringName = "res://challenge_files/day_3/test.txt"
var _challenge_file: StringName = "res://challenge_files/day_3/challenge.txt"


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(solve_challenge_1)
	day_panel.challenge_2_pressed.connect(solve_challenge_2)


func solve_challenge_1(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var data: Array = _load_data(test)
	var total: int = 0
	var total_test: int = 0
	for i in data:
		print("------------")
		print(i)
		total += _iterate_data(i)
		total_test += gather_number(i, 2)

	print(total)
	print("Total test.: {0}".format([total_test]))
	day_panel.update_log_text("Status.: Finished Challenge 1")


func solve_challenge_2(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")
	var data: Array = _load_data(test)
	var total: int = 0
	for i in data:
		print("------------")
		print(i)
		total += gather_number(i, 12)
	print("Output value.: {0}".format([total]))
	day_panel.update_log_text("Status.: Finished Challenge 2")


func _iterate_data(input: String) -> int:
	var max: int = 0
	for i in range(len(input)):
		for j in range(i + 1, len(input)):
			if int(input[i] + input[j]) > max:
				max = int(input[i] + input[j])
	return max


func gather_number(input: String, iterations: int) -> int:
	var temp_array: Array
	var output_string: String = ""
	temp_array = recursive_solution(input, -1, iterations)
	temp_array.reverse()
	for i in temp_array:
		output_string += str(i)
	return int(output_string)


func recursive_solution(input: String, position: int, iterations: int= 12) -> Array:
	if iterations == 0: 
		return []
	var max: int = 0
	var pos: int = 0
	# print(range(len(input) - iterations, position, -1))
	for i in range(len(input) - iterations, position, -1):
		if int(input[i]) >= max:
			max = int(input[i])
			pos = i
	# print(max)
	var output = recursive_solution(input, pos, iterations -1)
	output.append(max)
	return output


func _not_twelve_fori(input: String) -> int:
	var max: int = 0
	var removed: String = ""
	for i in range(len(input)):
		for j in range(i + 1, len(input)):
			for k in range(j + 1, len(input)):
				removed = input
				removed = removed.erase(k)
				removed = removed.erase(j)
				removed = removed.erase(i)
				if int(removed) > max:
					max = int(removed)
	return max



func _load_data(test: bool) -> Array:
	var file: Array
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	return file