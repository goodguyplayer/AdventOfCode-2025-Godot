class_name DayPanel
extends Control

signal challenge_1_pressed(test_mode:bool)
signal challenge_2_pressed(test_mode:bool)
signal reset_pressed()

@onready var day_num: Label = %DayNum
@onready var challenge_1: Button = %Challenge1
@onready var challenge_2: Button = %Challenge2
@onready var test_mode: CheckButton = %TestMode
@onready var text_edit: TextEdit = %TextEdit
@onready var reset: Button = %Reset
@onready var back_to_menu: Button = %BacktoMenu

@export var day: int = 0

var _main_menu: StringName = "uid://ck63ynf2xcnwd"


func _ready() -> void:
	day_num.text = "Day %d" % day

	challenge_1.pressed.connect(_cha_1_pressed)
	challenge_2.pressed.connect(_cha_2_pressed)
	reset.pressed.connect(_reset_pressed)
	test_mode.toggled.connect(_test_mode_pressed)
	back_to_menu.pressed.connect(_back_to_menu)


func update_log_text(text: String) -> void:
	text_edit.text = text


func _cha_1_pressed() -> void:
	challenge_1_pressed.emit(test_mode.toggle_mode)


func _cha_2_pressed() -> void:
	challenge_2_pressed.emit(test_mode.toggle_mode)


func _reset_pressed() -> void:
	reset_pressed.emit()


func _test_mode_pressed(toggled: bool) -> void:
	if toggled:
		test_mode.text = "Test Mode - Enabled"
	else:
		test_mode.text = "Test Mode - Disabled"

	
func _back_to_menu() -> void:
	get_tree().change_scene_to_file(_main_menu)
