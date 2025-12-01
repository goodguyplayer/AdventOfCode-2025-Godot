extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

@onready var number_rotation: TextEdit = %NumberRotation
@onready var day_one_solution: TextEdit = %DayOneSolution
@onready var day_two_solution: TextEdit = %DayTwoSolution

@export var starting_position: int = 50

signal finished_ticking()


var _test_file: StringName = "res://challenge_files/day_1/test.txt"
var _challenge_file: StringName = "res://challenge_files/day_1/challenge.txt"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_panel.challenge_1_pressed.connect(challenge_1_solve)
	day_panel.challenge_2_pressed.connect(challenge_2_solve)

	day_panel.reset_pressed.connect(_reset)




func challenge_1_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")


	var data: Array = _prepare_data(test)
	var num_position: int = starting_position
	var total: int = 0
	_update_number_rotation(starting_position, starting_position)
	for item in data:
		# print(item[1])
		if item[0] == "L":
			num_position = await _rotate_left(num_position, item[1])
		else:
			num_position = await _rotate_right(num_position, item[1])

		if (_solution_one_check(num_position)):
			total += 1
			_update_day_one_sol_text(total)
		await  get_tree().create_timer(0.1).timeout

	day_panel.update_log_text("Status.: Challenge 1 completed")


func challenge_2_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")

	var data: Array = _prepare_data(test)
	var num_position: int = starting_position
	var total: int = 0
	var temp: int = 0
	_update_number_rotation(starting_position, starting_position)
	for item in data:
		# print(item[1])
		if item[0] == "L":
			temp = num_position
			num_position = await _rotate_left(num_position, item[1])
			total += _solution_two_check_left(temp, item[1])

		else:
			temp = num_position
			num_position = await _rotate_right(num_position, item[1])
			total += _solution_two_check_right(temp, item[1])

		if (_solution_one_check(num_position)):
			total += 1
		
		_update_day_two_sol_text(total)
		await  get_tree().create_timer(0.1).timeout
	day_panel.update_log_text("Status.: Challenge 2 completed")




func _prepare_data(test: bool) -> Array:
	var to_return: Array = []
	var file: Array = []
	var regex = RegEx.new()
	regex.compile("(?<direction>[^\\d])(?<digit>[\\d]+)")
	var result

	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)

	for line in file:
		result = regex.search(line)
		to_return.append([result.get_string("direction"), int(result.get_string("digit"))])
	return to_return


func _rotate_right(position_data: int, rotations: int) -> int:
	var to_return: int = position_data
	to_return += rotations
	while to_return > 99:
		to_return -= 100
	print("Rotated {0} Right {1} times, resulting {2}".format([position_data, rotations, to_return]))
	await _update_number_rotation(position_data, to_return)
	return to_return


func _rotate_left(position_data: int, rotations: int) -> int:
	var to_return: int = position_data
	to_return -= rotations
	while to_return < 0:
		to_return += 100
	print("Rotated {0} Left {1} times, resulting {2}".format([position_data, rotations, to_return]))
	await _update_number_rotation(position_data, to_return)
	return to_return


func _update_number_rotation(original: int, to_rotate: int) -> void:
	number_rotation.text = str(original)
	if original < to_rotate:
		for i in range(original, to_rotate, 1):
			number_rotation.text = str(i)
			await  get_tree().create_timer(0.01).timeout
	else:
		for i in range(original, to_rotate, -1):
			number_rotation.text = str(i)
			await  get_tree().create_timer(0.01).timeout

	finished_ticking.emit()


func _solution_one_check(val: int) -> bool:
	return (val == 0)


func _solution_two_check_left(position: int, rotations: int) -> int:
	var to_return: int = 0
	for i in range(0, rotations):
		position -= 1
		if (position == 0):
			to_return += 1
		if (position < 0):
			position += 100
	
	if (position == 0 and to_return > 0):
		to_return -= 1
	if (to_return > 0):
		print("-- It equalled 0 x{0} times".format([to_return]))
	return to_return


func _solution_two_check_right(position: int, rotations: int) -> int:
	var to_return: int = 0
	for i in range(0, rotations):

		position += 1

		if (position > 99):
			position -= 100

		if (position == 0):
			to_return += 1

	if (position == 0 and to_return > 0):
		to_return -= 1

	if (to_return > 0):
		print("-- It equalled 0 x{0} times".format([to_return]))
	return to_return



func _update_day_one_sol_text(val: int) -> void:
	day_one_solution.text = str(val)


func _update_day_two_sol_text(val: int) -> void:
	day_two_solution.text = str(val)


func _reset() -> void:
	_update_number_rotation(starting_position, starting_position)
	day_one_solution.text = ""
	day_two_solution.text = ""