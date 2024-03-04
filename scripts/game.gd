extends Node2D

@onready var bunny_emotion = preload("res://scripts/bunny_emotion.gd").new()
@onready var friend = $Friend
@onready var support_creator = $"Support Creator"
@onready var legend = $Legend


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_success_screen():
	var finished_game = preload("res://scenes/finished_game.tscn").instantiate()
	add_child(finished_game)

func spawn_game_over_screen():
	var game_over = preload("res://scenes/game_over.tscn").instantiate()
	game_over.should_use_negative_emotes = true
	
	add_child(game_over)

func _on_friend_modified_happiness(happiness):
	if happiness == friend.max_happiness or happiness == 0:
		friend.clear_friend()
		support_creator.queue_free()
		legend.queue_free()
	
	match happiness:
		friend.max_happiness:
			spawn_success_screen()
		0:
			spawn_game_over_screen()
