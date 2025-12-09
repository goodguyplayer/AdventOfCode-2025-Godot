class_name Circuit
extends Node

var junction_boxes: Array[Vector3i] = []
var pairs: Array = []


func is_pair_already_connected(vector_1: Vector3i, vector_2: Vector3i) -> bool:
	if !junction_boxes.has(vector_1): return false
	if !junction_boxes.has(vector_2): return false
	return true


func one_already_connected(vector_1: Vector3i, vector_2: Vector3i) -> bool:
	if junction_boxes.has(vector_1): return true
	if junction_boxes.has(vector_2): return true
	return false


func juction_box_already_connected(vector_1: Vector3i) -> bool:
	return junction_boxes.has(vector_1)


func add_pair(vector_1: Vector3i, vector_2: Vector3i) -> void:
	var to_connect: Array = [vector_1, vector_2]
	to_connect.sort()
	pairs.append(to_connect)

	if !junction_boxes.has(vector_1): junction_boxes.append(vector_1)
	if !junction_boxes.has(vector_2): junction_boxes.append(vector_2)


func _vector_comparison(vector_1: Vector3i, vector_2: Vector3i) -> bool:
	return vector_1 == vector_2
