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
