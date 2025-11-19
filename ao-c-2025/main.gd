extends Control

@onready var grid_container: GridContainer = %GridContainer
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var quit: Button = %Button


var _btn_path: StringName = "uid://wptlx1h8jahe"

var _day_path: StringName = "res://days/day_{0}/day_{0}.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, 25):
		add_button(i)
	
	quit.pressed.connect(_quit)

func add_button(day: int) -> void:
	var btn: ButtonDay = load(_btn_path).instantiate()
	btn.day_number = day
	btn.chosen_day.connect(_button_pressed)
	grid_container.add_child(btn)


func _button_pressed(day: int) -> void:
	var path = _day_path.format({"0": str(day)})
	if FileAccess.file_exists(path):
		get_tree().change_scene_to_file(path)
	else:
		animation_player.play("fade_in_error")


func _quit() -> void:
	get_tree().quit()