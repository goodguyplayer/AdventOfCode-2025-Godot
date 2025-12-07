extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

@export var day_number: int = 5

var _test_file: StringName = "res://challenge_files/day_{0}/test.txt".format([day_number])
var _challenge_file: StringName = "res://challenge_files/day_{0}/challenge.txt".format([day_number])


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(solve_challenge_1)
	day_panel.challenge_2_pressed.connect(solve_challenge_2)


func solve_challenge_1(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var ingredients: Ingredients = _load_data(test)
	var data_output: Array = ingredients.gather_fresh_ingredients()
	print(data_output)
	print("Total.: {0}".format([data_output.size()]))
	day_panel.update_log_text("Status.: Finished Challenge 1")



func solve_challenge_2(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")
	var ingredients: Ingredients = _load_data(test)
	var data_output: Array = ingredients.all_ranges()
	var total: int = 0
	for i in data_output:
		total += (i[1] + 1- i[0])
	print(data_output)
	print("Total.: {0}".format([total]))
	day_panel.update_log_text("Status.: Finished Challenge 2")




func _load_data(test: bool) -> Ingredients:
	var ingredients: Ingredients = Ingredients.new()
	var fetch_ranges: bool = true

	var file: Array
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	
	var helper: PackedStringArray
	for i in file:
		if i == "":
			fetch_ranges = false

		if fetch_ranges:
			helper = i.split("-")
			ingredients.id_ranges.append([int(helper[0]), int(helper[1])])
		else:
			if i == "": continue
			ingredients.ingredients_id.append(int(i))
	return ingredients
