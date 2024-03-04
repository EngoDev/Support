extends Node

const HAPPY_LEVEL = 90
const NEUTRAL_LEVEL = 50
const SAD_LEVEL = 30

var _support_type_script = SupportType.new()


var _player_support = []

var recipes = [
	Recipe.new(SupportType.TALKING, SupportType.CURIOSITY, SupportType.QUESTION),
	Recipe.new(SupportType.EMPATHY, SupportType.EMPATHY, SupportType.HUG),
	Recipe.new(SupportType.TALKING, SupportType.LISTENING, SupportType.ADVICE),
	Recipe.new(SupportType.TALKING, SupportType.TALKING, SupportType.FEEDBACK),
]


func get_support() -> Array[int]:
	return _player_support

func get_support_text() -> String:
	return _support_type_script.array_to_text(_player_support)
	
func get_serialized_support_text() -> String:
	return ""

func reset_support():
	_player_support = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
