extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rect_size = get_theme_font("normal_font").get_string_size(text)
	
	custom_minimum_size.x = rect_size.x
	#control.layout.rect_size.x = rect_size.x
	#transform.rect_size.x = rect_size.x
	#object.rect_size = rect_size.x
	#rect_size.x = 0.0
	#for line in text.split("\n"):
		#rect_size.x = max(rect_size.x, get_font("normal_font").get_string_size(line).x)
