extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler


var _test_file: StringName = "res://challenge_files/day_4/test.txt"
var _challenge_file: StringName = "res://challenge_files/day_4/challenge.txt"


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(solve_challenge_1)


func solve_challenge_1(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var data: Array = _load_data(test)
	var count: int
	var total: int = 0
	var visual_data: Array
	for i in len(data):
		visual_data.append([])
		for j in len(data[i]):
			if data[i][j] == ".":
				visual_data[i].append(".")
				continue
			count = 0
			count += 1 if is_paper_near(data, i-1, j-1) else 0
			count += 1 if is_paper_near(data, i-1, j) else 0
			count += 1 if is_paper_near(data, i-1, j+1) else 0
			count += 1 if is_paper_near(data, i, j-1) else 0
			count += 1 if is_paper_near(data, i, j+1) else 0
			count += 1 if is_paper_near(data, i+1, j-1) else 0
			count += 1 if is_paper_near(data, i+1, j) else 0
			count += 1 if is_paper_near(data, i+1, j+1) else 0
			if count < 4:
				total += 1
				visual_data[i].append("X")
			else:
				visual_data[i].append(data[i][j])
	print("Total.: {0}".format([total]))
	# for i in visual_data:
	# 	print(str(i))
	day_panel.update_log_text("Status.: Finished Challenge 1")
		



func is_paper_near(data: Array, to_check_x: int, to_check_y: int) -> bool:
	if to_check_x < 0 or to_check_x >= len(data):
		return false
	if to_check_y < 0 or to_check_y >= len(data[to_check_x]):
		return false
	if data[to_check_x][to_check_y] != "@":
		return false
	return true




func _load_data(test: bool) -> Array:
	var file: Array
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	return file