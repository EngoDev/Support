extends Node2D

@onready var bunny_emotion = preload("res://scripts/bunny_emotion.gd").new()
@onready var friend = $Friend
@onready var support_creator = $"Support Creator"
@onready var legend = $Legend


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_success_screen():
	var finished_game = preload("res://scenes/finished_game.tscn").instantiate()
	add_child(finished_game)


func _on_friend_modified_happiness(happiness):
	if happiness == friend.max_happiness:
		friend.clear_friend()
		support_creator.queue_free()
		legend.queue_free()
		
		spawn_success_screen()
		# support_creator.queue_free()
		
