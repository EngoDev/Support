class_name Recipe
extends Resource

#var ingredients: Array[int]
var first: int
var second: int
var result: int

func _init(_first, _second, _result):
	first = _first
	second = _second
	result = _result
	
func is_match(_first, _second) -> bool:
	return (first == _first and second == _second) or (first == _second and second == _first)

func is_type_in_recipe(support_type: int) -> bool:
	return (first == support_type or second == support_type)
