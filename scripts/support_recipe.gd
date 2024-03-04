extends ItemList

signal added_support(support)

var support_type_script = SupportType.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var friend = get_parent().get_parent().get_node("Friend")
	friend.cleared_friend_request.connect(_handle_cleared_friend_request)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("clear_support"):
		remove_item(get_item_count() - 1)
	
	var last_support_type = -1
	var last_item_index = -1

	var pressed_support_type = get_support_type_from_press()

	if pressed_support_type == -1:
		return
		
	if get_item_count() != 0:
		last_item_index = get_item_count() - 1
		last_support_type = support_type_script.text_to_support_type(get_item_text(last_item_index))
		
	var combined = combine_support(last_support_type, pressed_support_type)
	
	if combined != -1:
		remove_item(last_item_index)
		add_item(support_type_script.support_type_to_text(combined), null, false)
	elif get_item_count() < max_columns:
		add_item(support_type_script.support_type_to_text(pressed_support_type), null, false)

	emit_signal("added_support", get_support_text_from_item_list())

func combine_support(first_support_type: int, second_support_type: int) -> int:
	for recipe in Global.recipes:
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

func get_support_text_from_item_list() -> String:
	var text = ""
	for i in get_item_count():
		text += get_item_text(i)
	
	return text

func _handle_cleared_friend_request():
	clear()
