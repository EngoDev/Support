class_name SupportType

enum {
	LISTENING,
	EMPATHY,
	CURIOSITY,
	TALKING,
	QUESTION,
	HUG,
	ADVICE,
	FEEDBACK,
}

var LARGEST_BASIC_SUPPORT_INDEX = 3
var COUNT = 8

	
func support_type_to_text(support_type: int) -> String:
	match support_type:
		SupportType.LISTENING:
			return "👂🏻"
		SupportType.EMPATHY:
			return "💞"
		SupportType.CURIOSITY:
			return "🦝"
		SupportType.TALKING:
			return "🗣"
		SupportType.QUESTION:
			return "❓"
		SupportType.HUG:
			return "🫂"
		SupportType.ADVICE:
			return "🗨️"
		SupportType.FEEDBACK:
			return "💯"
		_:
			return ""

func text_to_support_type(text: String) -> int:
	match text:
		"👂🏻":
			return SupportType.LISTENING
		"💞":
			return SupportType.EMPATHY
		"🦝":
			return SupportType.CURIOSITY
		"🗣":
			return SupportType.TALKING
		"❓":
			return SupportType.QUESTION
		"🫂":
			return SupportType.HUG
		"🗨️":
			return SupportType.ADVICE
		"💯":
			return SupportType.FEEDBACK
		_:
			return -1
			
func array_to_text(array: Array[int]) -> String:
	var text = ""
	for support_type in array:
		text += support_type_to_text(support_type)
		
	return text
