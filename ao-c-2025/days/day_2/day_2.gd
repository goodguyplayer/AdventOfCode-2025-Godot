extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

var _test_file: StringName = "res://challenge_files/day_2/test.txt"
var _challenge_file: StringName = "res://challenge_files/day_2/challenge.txt"


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(challenge_1_solve)
	day_panel.challenge_2_pressed.connect(challenge_2_solve)




func challenge_1_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")

	var total: int = 0
	var data: Array = _load_ranges(test)
	for item in data:
		for i in range(item[0], item[1] + 1):
			if _brute_force_solution(i): total += i
	
	print(total)
	day_panel.update_log_text("Status.: Finished Challenge 1")


func challenge_2_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")
	var regex = RegEx.new()
	regex.compile("^(\\d+)\\1+$")

	var total: int = 0
	var data: Array = _load_ranges(test)
	for item in data:
		for i in range(item[0], item[1] + 1):
			if _regex_solution(i, regex): total += i
	
	print(total)
	day_panel.update_log_text("Status.: Finished Challenge 2")


func _regex_solution(val: int, regex) -> bool:
	
	var helper = str(val)
	helper = regex.sub(helper, "", true)
	if len(helper) > 0:
		return false
	print(str(val) + " is invalid")
	return true
	


func _brute_force_solution(val: int) -> bool:
	var helper: String = str(val)
	if len(helper) % 2 == 0:
		if helper.substr(0, len(helper)/2) == helper.substr(len(helper)/2):
			print(helper + " is invalid")
			return true
	return false



func _load_ranges(test: bool) -> Array:
	var data = []
	var file: String
	var helper: Array
	if test:
		file = file_handler.load_file_string(_test_file)
	else:
		file = file_handler.load_file_string(_challenge_file)
	for item in file.split(","):
		helper = item.split("-")
		data.append([int(helper[0]), int(helper[1])])
	for i in data:
		print(i)
	return data
	
