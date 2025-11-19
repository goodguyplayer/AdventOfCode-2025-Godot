extends Control

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler
@onready var text_edit: TextEdit = %TextEdit

var _test_file: StringName = "res://challenge_files/day_0/test.txt"
var _challenge_file: StringName = "res://challenge_files/day_0/challenge.txt"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_panel.challenge_1_pressed.connect(challenge_1_solve)
	day_panel.challenge_2_pressed.connect(challenge_2_solve)

	day_panel.reset_pressed.connect(reset_pressed)



func challenge_1_solve(test: bool) -> void:
	text_edit.text += " ----------------- \n"
	text_edit.text += " Challenge 1 chosen \n"
	text_edit.text += " Test mode: %s \n" %test
	text_edit.text += " ----------------- \n"
	var file: Array = []
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)

	for line in file:
		text_edit.text += line + "\n"

	text_edit.text += " ----------------- \n"
	text_edit.text += " ----------------- \n"
	day_panel.update_log_text("Status.: Finished code execution")


func challenge_2_solve(test: bool) -> void:
	text_edit.text += " ----------------- \n"
	text_edit.text += " Challenge 2 chosen \n"
	text_edit.text += " Test mode: %s \n" %test
	text_edit.text += " ----------------- \n"
	var file: Array = []
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)

	for line in file:
		text_edit.text += line + "\n"

	text_edit.text += " ----------------- \n"
	text_edit.text += " ----------------- \n"
	day_panel.update_log_text("Status.: Finished code execution")


func reset_pressed() -> void:
	text_edit.clear()
	day_panel.update_log_text("Status.: Awaiting execution")
