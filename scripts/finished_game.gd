extends Control

@export var should_use_negative_emotes = false

@onready var animation_player = $AnimationPlayer

@onready var bunny_emotion = preload("res://scripts/bunny_emotion.gd").new()

const MAX_EMOTES = 10
const MINIMUM_EMOTES = 5

const EMOTE_SPAWN_LEFT_X_OFFSET = 300
const EMOTE_SPAWN_RIGHT_X_OFFSET = 100
const EMOTE_SPAWN_Y_OFFSET = 100

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var emotes_amount = rng.randi_range(MINIMUM_EMOTES, MAX_EMOTES)
	var screen_size = get_viewport().get_visible_rect().size
	
	for i in range(emotes_amount):
		var x = randi_range(EMOTE_SPAWN_LEFT_X_OFFSET, screen_size.x - EMOTE_SPAWN_RIGHT_X_OFFSET)
		var y = randi_range(screen_size.y / 2, screen_size.y - EMOTE_SPAWN_Y_OFFSET)
		spawn_emotion(Vector2(x, y))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(DisplayServer.screen_get_size())

func spawn_emotion(position: Vector2):
	var bunny = preload("res://scenes/emotion.tscn").instantiate()
	if should_use_negative_emotes:
		bunny.set_emotion(bunny_emotion.pick_random_negative())
	else:
		bunny.set_emotion(bunny_emotion.pick_random_happy())

	bunny.position = position
	add_child(bunny)


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

