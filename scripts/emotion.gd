extends Control

#@onready var bunny = $bunny
@export var bunny: Node
@export var negative_particles: Node
@export var happy_particles: Node
@export var animation_player = Node

@onready var destroy_timer = $destroy_timer

var bunny_emotion = Emotion.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	destroy_timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not animation_player.is_playing():
		var animation_name = get_animation_name()
		if animation_name != animation_player.current_animation:
			animation_player.stop()
			animation_player.play(animation_name) 
		
func get_animation_name():
	if bunny_emotion.is_happy(bunny.texture):
		return "happy"
	else:
		return "angry"

func set_emotion(texture):
	bunny.set_texture(texture)
	
	negative_particles.texture = texture
	happy_particles.texture = texture
	
	if bunny_emotion.is_happy(texture):
		happy_particles.set_process(true)
		happy_particles.visible = true
	elif bunny_emotion.is_negative(texture):
		negative_particles.set_process(true)
		negative_particles.visible = true


func _on_destroy_timer_timeout():
	queue_free()
