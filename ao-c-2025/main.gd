extends Control

@onready var grid_container: GridContainer = %GridContainer

var _btn_path: StringName = "uid://wptlx1h8jahe"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, 25):
		add_button(i)


func add_button(day: int) -> void:
	var btn: ButtonDay = load(_btn_path).instantiate()
	btn.day_number = day
	btn.chosen_day.connect(_button_pressed)
	grid_container.add_child(btn)


func _button_pressed(day: int) -> void:
	print("You chose %d" % day)
