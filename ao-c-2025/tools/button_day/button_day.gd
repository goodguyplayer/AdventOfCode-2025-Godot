class_name ButtonDay
extends Button

signal chosen_day(day: int)

var day_number: int = 0


func _ready() -> void:
	text = "[%0*d]" % [2, day_number]


func _pressed() -> void:
	chosen_day.emit(day_number)