extends Control

## UNSOLVED

@onready var day_panel: DayPanel = %DayPanel
@onready var file_handler: FileHandler = %FileHandler

@export var day_number: int = 8

var _test_file: StringName = "res://challenge_files/day_{0}/test.txt".format([day_number])
var _challenge_file: StringName = "res://challenge_files/day_{0}/challenge.txt".format([day_number])


func _ready() -> void:
	day_panel.challenge_1_pressed.connect(challenge_1_solve)
	day_panel.challenge_2_pressed.connect(challenge_2_solve)


func challenge_1_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 1")
	var data = _load_data(test)
	var data_distance = distance_list(data, test)
	var already_checked: Array = []
	var lowest_dist_vect: Vector3i
	var circuits: Array[Circuit] = []
	var circuit: Circuit
	var new_circuit: bool = true
	var sizes_list: Array[int] = []

	# data.sort_custom(sort_descending)

	for i in data_distance:
		if i[0] in already_checked: continue
		already_checked.append(i[0])
		new_circuit = true
		for circ in circuits:
			if circ.is_pair_already_connected(i[1], i[2]): 
				new_circuit = false
				# print("{0} and {1} are already a pair".format([i[1], i[2]]))
				break
			if circ.one_already_connected(i[1], i[2]):
				circ.add_pair(i[1], i[2])
				new_circuit = false
				# print("{0} or {1} was already connected".format([i[1], i[2]]))
				break
		if new_circuit:
			# print("{0} and {1} - New circuit".format([i[1], i[2]]))
			circuit = Circuit.new()
			circuit.add_pair(i[1], i[2])
			circuits.append(circuit)


	# for i in data:
	# 	lowest_dist_vect = find_lowest_distance(i, data)
	# 	new_circuit = true
	# 	for circ in circuits:
	# 		if circ.is_pair_already_connected(i, lowest_dist_vect): 
	# 			new_circuit = false
	# 			print("{0} and {1} are already a pair".format([i, lowest_dist_vect]))
	# 			break
	# 		if circ.one_already_connected(i, lowest_dist_vect):
	# 			circ.add_pair(i, lowest_dist_vect)
	# 			new_circuit = false
	# 			print("{0} or {1} was already connected".format([i, lowest_dist_vect]))
	# 			break
	# 	if new_circuit:
	# 		print("{0} and {1} - New circuit".format([i, lowest_dist_vect]))
	# 		circuit = Circuit.new()
	# 		circuit.add_pair(i, lowest_dist_vect)
	# 		circuits.append(circuit)
		
	for circ in circuits:
		# for i in circ.pairs:
			# print(i)
		# print(circ.junction_boxes)
		sizes_list.append(circ.junction_boxes.size())
		# print("---------------------------------")
	
	sizes_list.sort_custom(sort_descending)
	print(sizes_list)
	print(sizes_list[0] * sizes_list[1] * sizes_list[2])
	print(data_distance.size())
	
	day_panel.update_log_text("Status.: Finished Challenge 1")


func challenge_2_solve(test: bool) -> void:
	day_panel.update_log_text("Status.: Running Challenge 2")

	day_panel.update_log_text("Status.: Finished Challenge 2")


func find_lowest_distance(given_vector: Vector3i, data_array: Array) -> Vector3i:
	var lowest: Vector3i
	var stored_distance: float = INF
	for i in data_array:
		if i == given_vector: continue
		if given_vector.distance_to(i) < stored_distance: 
			lowest = i
			stored_distance = given_vector.distance_to(i)
	return lowest


func distance_list(data_array, test_mode: bool) -> Array:
	var to_return: Array = []
	var to_append: bool = true
	var size_limit: int = (data_array.size()/2 + 1) if test_mode else 1000
	for i in data_array:
		if to_return.size() >= size_limit:
			to_return.sort_custom(sort_by_distance)
			to_return.resize(size_limit)
		for j in data_array:
			if i == j: continue
			to_append = true
			for k in to_return:
				if k[0] == i.distance_to(j): 
					to_append = false
					break
			if to_append:
				to_return.append([i.distance_to(j), i, j])
	to_return.sort_custom(sort_by_distance)
	to_return.resize(size_limit)
	return to_return


func sort_by_distance(a, b):
	if a[0] < b[0]:
		return true
	return false


func sort_descending(a, b):
	if a > b:
		return true
	return false


func _load_data(test: bool) -> Array:
	var file: Array
	var output: Array = []
	var helper
	if test:
		file = file_handler.load_file_array(_test_file)
	else:
		file = file_handler.load_file_array(_challenge_file)
	for i in file:
		helper = i.split(",")
		output.append(Vector3i(int(helper[0]), int(helper[1]), int(helper[2])))
	return output
