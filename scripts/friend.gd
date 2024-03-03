extends Node2D

signal cleared_friend_request()

@export var win_score: int
@export var min_sequence = 1
@export var max_sequence = 2
@export var start_timer_sec = 60
@export var allow_complex_support = false

@onready var request_text = $request_text
@onready var sprite = $sprite
@onready var support_recipe_script = load("res://scripts/support_recipe.gd").new()

var rng = RandomNumberGenerator.new()
var support_type_script = SupportType.new()
#var support_recipe_script = SupportRecipe.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var support_creator = get_parent().get_node("Support Creator").get_node("support_recipe")
	support_creator.added_support.connect(handle_added_support)
	request_text.text = support_type_script.array_to_text(generate_random_sequence())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func generate_random_sequence() -> Array[int]:
	var sequence: Array[int] = []
	var max_options = support_type_script.LARGEST_BASIC_SUPPORT_INDEX
	var sequence_len = rng.randi_range(min_sequence, max_sequence)
	
	if allow_complex_support:
		max_options = support_type_script.COUNT
	
	sequence.append(rng.randi_range(0, max_options))
	for i in range(sequence_len - 1):
		sequence.append(generate_valid_support_type(sequence[-1], max_options))
		
	return sequence


func generate_valid_support_type(previous_support_type: int, max_options: int) -> int:
	var combined = 0
	var valid_support_type
	
	while combined != -1:
		var support_type = rng.randi_range(0, max_options)
		combined = support_recipe_script.combine_support(previous_support_type, support_type)
		valid_support_type = support_type

	return valid_support_type


func handle_added_support(support_text: String):
	if support_text == request_text.text:
		request_text.text = support_type_script.array_to_text(generate_random_sequence())
		emit_signal("cleared_friend_request")
