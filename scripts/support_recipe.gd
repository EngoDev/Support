extends ItemList

#@export var max_items: int  

var recipes = [
	Recipe.new(SupportType.TALKING, SupportType.CURIOSITY, SupportType.QUESTION),
	Recipe.new(SupportType.EMPATHY, SupportType.EMPATHY, SupportType.HUG),
	Recipe.new(SupportType.TALKING, SupportType.LISTENING, SupportType.ADVICE),
	Recipe.new(SupportType.TALKING, SupportType.TALKING, SupportType.FEEDBACK),
]

var support_type_script = SupportType.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("clear_support"):
		clear()
	
	var last_support_type = -1
	var last_item_index = -1
	#var support_to_add

	var pressed_support_type = get_support_type_from_press()

	if pressed_support_type == -1:
		return
		
	if get_item_count() != 0:
		last_item_index = get_item_count() - 1 # get_item_at_position(Vector2(get_item_count() - 1, 0))
		last_support_type = support_type_script.text_to_support_type(get_item_text(last_item_index))
		
	var combined = combine_support(last_support_type, pressed_support_type)
	
	if combined != -1:
		remove_item(last_item_index)
		add_item(support_type_script.support_type_to_text(combined), null, false)
	elif get_item_count() < max_columns:
		add_item(support_type_script.support_type_to_text(pressed_support_type), null, false)

func combine_support(first_support_type: int, second_support_type: int) -> int:
	for recipe in recipes:
		if recipe.is_match(first_support_type, second_support_type):
			return recipe.result
	
	return -1
	
func get_support_type_from_press() -> int:
	if Input.is_action_just_pressed("listening"):
		return SupportType.LISTENING
		
	if Input.is_action_just_pressed("empathy"):
		return SupportType.EMPATHY
	
	if Input.is_action_just_pressed("curiosity"):
		return SupportType.CURIOSITY
	
	if Input.is_action_just_pressed("talking"):
		return SupportType.TALKING
	
	return -1
