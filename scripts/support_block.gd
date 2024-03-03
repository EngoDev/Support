extends Control

enum SUPPORT_TYPE {
	LISTENING,
	EMPATHY,
	CURIOSITY,
	TALKING,
	QUESTION,
	HUG,
	ADVICE,
	FEEDBACK,
}

@onready var support_text = $SupportText

var type: SUPPORT_TYPE

# signal added_support(support_type: SUPPORT_TYPE)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
#func set_support_type(support_type: SUPPORT_TYPE):
	#type = support_type
	#support_text.text = _support_type_to_text(support_type)
	
	
#func _support_type_to_text(support_type: SUPPORT_TYPE) -> String:
	#match support_type:
#SupportType.LISTENING:
			#return "👂🏻"
#SupportType.EMPATHY:
			#return "💞"
#SupportType.CURIOSITY:
			#return "🦝"
#SupportType.TALKING:
			#return "🗣️"
#SupportType.QUESTION:
			#return "❓"
#SupportType.HUG:
			#return "🫂"
#SupportType.ADVICE:
			#return "🗨️"
#SupportType.FEEDBACK:
			#return "💯"
		#_:
			#return ""
