extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

var _test_file: StringName = "res://challenge_files/day_3/test.txt"
var _challenge_file: StringName = "res://challenge_files/day_3/challenge.txt"


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(solve_challenge_1)


func solve_challenge_1(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var data: Array = _load_data(test)
	var total: int = 0
	for i in data:
		print("------------")
		print(i)
		total += _iterate_data(i)
	print(total)
	day_panel.update_log_text("Status.: Finished Challenge 1")


func _iterate_data(input: String) -> int:
	var max: int = 0
	for i in range(len(input)):
		for j in range(i + 1, len(input)):
			if int(input[i] + input[j]) > max:
				max = int(input[i] + input[j])
	return max




func _load_data(test: bool) -> Array:
	var file: Array
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	return file