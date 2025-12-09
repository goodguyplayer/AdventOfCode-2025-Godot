extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

@export var day_number: int = 9

var _test_file: StringName = "res://challenge_files/day_{0}/test.txt".format([day_number])
var _challenge_file: StringName = "res://challenge_files/day_{0}/challenge.txt".format([day_number])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_panel.challenge_1_pressed.connect(challenge_1_solve)
	day_panel.challenge_2_pressed.connect(challenge_2_solve)



func challenge_1_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var data: Array[Vector2i] = _load_data(test)
	var calculated_area: int = 0
	var abs_math: Vector2i
	var largest_area: int = 0
	for i in data:
		for j in data:
			if i == j: continue
			abs_math = abs(j-i)
			calculated_area = (abs_math.x + 1) * (abs_math.y + 1)
			# print("Calculated Area between {1} and {2}.: {0}".format([calculated_area, i, j]))
			if calculated_area > largest_area:
				largest_area = calculated_area
	print("Largest Area.: {0}". format([largest_area]))

	day_panel.update_log_text("Status.: Finished Challenge 1")


func challenge_2_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")

	day_panel.update_log_text("Status.: Finished Challenge 2")


func _load_data(test: bool) -> Array[Vector2i]:
	var file: Array
	var output: Array[Vector2i] = []
	var helper
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	for i in file:
		helper = i.split(",")
		output.append(Vector2i(int(helper[0]), int(helper[1])))
	return output
