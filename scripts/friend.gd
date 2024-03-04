extends Node2D

## Emits when the player's support pattern matches the friend pattern
signal cleared_friend_request()
## Emits when the happiness of the friend has been modified
signal modified_happiness(happiness: int)

@export var win_score: int
@export var min_sequence = 1
@export var max_sequence = 2
@export var happiness = 100
@export var remove_happiness_interval = 2
@export var remove_happiness_amount = 5
@export var increase_happiness_amount = 10
@export var start_timer_sec = 60
@export var allow_complex_support = false

@onready var request_text = $TextureRect/request_text
@onready var emotion_timer = $emotion_timer
@onready var remove_happiness_timer = $remove_happiness_timer

@onready var sprite = $sprite
@onready var happiness_bar = $happiness_bar

@onready var support_recipe_script = load("res://scripts/support_recipe.gd").new()
@onready var bunny_emotion = preload("res://scripts/bunny_emotion.gd").new()

var rng = RandomNumberGenerator.new()
var support_type_script = SupportType.new()

const SUPPORT_TEXT_PREFIX = "[center][wave]"

# Called when the node enters the scene tree for the first time.
func _ready():
	emotion_timer.start()
	remove_happiness_timer.start(remove_happiness_interval)
	
	var support_creator = get_parent().get_node("Support Creator").get_node("support_recipe")
	support_creator.added_support.connect(handle_added_support)
	request_text.text = SUPPORT_TEXT_PREFIX + support_type_script.array_to_text(generate_random_support_pattern())
	

func spawn_emotion(position: Vector2):
	var bunny = preload("res://scenes/emotion.tscn").instantiate()
	bunny.set_emotion(bunny_emotion.pick_emotion(happiness))
	bunny.position = position
	add_child(bunny)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	happiness_bar.value = happiness


func generate_random_support_pattern() -> Array[int]:
	var sequence: Array[int] = []
	var max_options = support_type_script.LARGEST_BASIC_SUPPORT_INDEX
	var sequence_len = rng.randi_range(min_sequence, max_sequence)
	
	if allow_complex_support:
		max_options = support_type_script.COUNT
	
	sequence.append(rng.randi_range(0, max_options))
	for i in range(sequence_len):
		sequence.append(generate_valid_support_type(sequence[-1], max_options))
		
	return sequence

## Generates one valid support type based on the support type before it and it won't generate
## a support type that is bigger than max_options  
func generate_valid_support_type(previous_support_type: int, max_options: int) -> int:
	var combined = 0
	var valid_support_type
	
	while combined != -1:
		var support_type = rng.randi_range(0, max_options)

		if not check_recipe_validity(previous_support_type, support_type):
			continue
		
		combined = support_recipe_script.combine_support(previous_support_type, support_type)
		valid_support_type = support_type

	return valid_support_type


## Checks if the desired support_type is valid based on recipe checks 
func check_recipe_validity(previous_support_type: int, support_type: int) -> bool:
	if support_type > support_type_script.LARGEST_BASIC_SUPPORT_INDEX:
		for recipe in Global.recipes:
			# Check if the previous support is not part of the recipe for the next support
			if recipe.is_type_in_recipe(previous_support_type) and recipe.result == support_type:
				return false
			elif recipe.result == support_type:
				# Check if the previous support can't produce the next support
				if support_recipe_script.combine_support(previous_support_type, recipe.first) != -1 or support_recipe_script.combine_support(previous_support_type, recipe.second) != -1:
					return false
	return true


func handle_added_support(support_text: String):
	var target_text = request_text.text.replace(SUPPORT_TEXT_PREFIX, "")
	if support_text == target_text:
		request_text.text = SUPPORT_TEXT_PREFIX + support_type_script.array_to_text(generate_random_support_pattern())
		increase_happiness()
		
		emit_signal("cleared_friend_request")
		emit_signal("modified_happiness", happiness)

func increase_happiness():
	var new = happiness + increase_happiness_amount
	if new > 100:
		new = 100
	
	happiness = new	
	
func decrease_happiness():
	var new = happiness - remove_happiness_amount
	if new < 0:
		new = 0
	
	happiness = new	


func _on_emotion_timer_timeout():
	var x = rng.randi_range(-50, 20)
	var y = rng.randi_range(-110, 90)
	spawn_emotion(Vector2(x, y))


func _on_remove_happiness_timer_timeout():
	decrease_happiness()
	emit_signal("modified_happiness", happiness)
