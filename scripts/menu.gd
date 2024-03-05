extends Control

@onready var animation_player = $AnimationPlayer

var chosen_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_levels_button_pressed():
	chosen_menu = preload("res://scenes/levels.tscn")
	animation_player.play("leave")


func _on_tutorial_button_pressed():
	chosen_menu = preload("res://scenes/tutorial.tscn")
	animation_player.play("leave")


func _on_about_button_pressed():
	chosen_menu = preload("res://scenes/about.tscn")
	animation_player.play("leave")


func _on_credits_button_pressed():
	chosen_menu = preload("res://scenes/credits.tscn")
	animation_player.play("leave")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "leave":
		var menu = chosen_menu.instantiate()
		add_child(menu)
