class_name Ingredients
extends Node

var id_ranges: Array = []
var ingredients_id: Array = []


func gather_fresh_ingredients() -> Array:
	var to_return: Array = []
	for i in ingredients_id:
		for ran in id_ranges:
			if i in to_return: continue
			if i>= ran[0] and i<=ran[1]:
				to_return.append(i)
				continue

	return to_return



func gather_fresh_ingredients_all() -> Array:
	var to_return: Array = []
	for i in ingredients_id:
		for ran in id_ranges:
			if i>= ran[0] and i<=ran[1]:
				to_return.append(i)
				continue

	return to_return


func all_ranges() -> Array:
	var to_return: Array = []
	var to_check: Array
	var to_remove: Array
	id_ranges.sort_custom(_custom_sort)
	while id_ranges.size() > 0:
		to_check = id_ranges[0]
		to_remove = [0]
		for i in range(1, len(id_ranges)):
			if to_check[1] >= id_ranges[i][0] and to_check[1] <= id_ranges[i][1]:
				to_check[0] = min(id_ranges[i][0], to_check[0])
				to_check[1] = max(id_ranges[i][1], to_check[1])
				to_remove.append(i)
			elif to_check[0] <= id_ranges[i][0] and to_check[1] >= id_ranges[i][1]:
				to_check[0] = min(id_ranges[i][0], to_check[0])
				to_check[1] = max(id_ranges[i][1], to_check[1])
				to_remove.append(i)
			# elif id_ranges[i][1] <= to_check[1]:
			# 	to_check[0] = min(id_ranges[i][0], to_check[0])
			# 	to_check[1] = max(id_ranges[i][1], to_check[1])
			# 	to_remove.append(i)
		to_return.append(to_check)
		for i in range(to_remove.size() -1, -1, -1):
			id_ranges.remove_at(to_remove[i])	
	to_return = _cleanup(to_return)		
	return to_return


func _cleanup(to_clean: Array) -> Array:
	var cleanup_happened: bool = false
	var to_return: Array = []
	var to_check: Array = []
	var to_remove: Array = []
	to_clean.sort_custom(_custom_sort)
	while to_clean.size() > 0:
		to_check = to_clean[0]
		to_remove = [0]
		for i in range(1, len(to_clean)):
			if to_check[1] >= to_clean[i][0] and to_check[1] <= to_clean[i][1]:
				to_check[0] = min(to_clean[i][0], to_check[0])
				to_check[1] = max(to_clean[i][1], to_check[1])
				to_remove.append(i)
				cleanup_happened = true
			elif to_check[0] <= to_clean[i][0] and to_check[1] >= to_clean[i][1]:
				to_check[0] = min(to_clean[i][0], to_check[0])
				to_check[1] = max(to_clean[i][1], to_check[1])
				to_remove.append(i)
				cleanup_happened = true
		to_return.append(to_check)
		for i in range(to_remove.size() -1, -1, -1):
			to_clean.remove_at(to_remove[i])			
	if cleanup_happened:
		return _cleanup(to_return)
	return to_return


func _custom_sort(a, b): 
	if a[0] < b[0]:
		return true
	return false