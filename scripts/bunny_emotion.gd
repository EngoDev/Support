class_name Emotion

const BUNNY_ANGRY = preload("res://assets/textures/bunny/bunny_angry.png")
const BUNNY_ANNOYED = preload("res://assets/textures/bunny/bunny_annoyed.png")
const BUNNY_APATHETIC = preload("res://assets/textures/bunny/bunny_apathetic.png")
const BUNNY_CANT_EVEN = preload("res://assets/textures/bunny/bunny_cant_even.png")
const BUNNY_CONTENT = preload("res://assets/textures/bunny/bunny_content.png")
const BUNNY_DEATH = preload("res://assets/textures/bunny/bunny_death.png")
const BUNNY_DEPRESSED = preload("res://assets/textures/bunny/bunny_depressed.png")
const BUNNY_DISSAPOINTED = preload("res://assets/textures/bunny/bunny_dissapointed.png")
const BUNNY_HAPPY = preload("res://assets/textures/bunny/bunny_happy.png")
const BUNNY_HEART_EYES = preload("res://assets/textures/bunny/bunny_heart_eyes.png")
const BUNNY_HELP = preload("res://assets/textures/bunny/bunny_help.png")
const BUNNY_KISS = preload("res://assets/textures/bunny/bunny_kiss.png")
const BUNNY_LOVE = preload("res://assets/textures/bunny/bunny_love.png")
const BUNNY_NO = preload("res://assets/textures/bunny/bunny_no.png")
const BUNNY_QUESTION = preload("res://assets/textures/bunny/bunny_question.png")
const BUNNY_SAD = preload("res://assets/textures/bunny/bunny_sad.png")
const BUNNY_SAD_2 = preload("res://assets/textures/bunny/bunny_sad_2.png")
const BUNNY_SAS = preload("res://assets/textures/bunny/bunny_sas.png")
const BUNNY_SCARED = preload("res://assets/textures/bunny/bunny_scared.png")
const BUNNY_SKEPTIC = preload("res://assets/textures/bunny/bunny_skeptic.png")
const BUNNY_SLEEP = preload("res://assets/textures/bunny/bunny_sleep.png")
const BUNNY_STAR = preload("res://assets/textures/bunny/bunny_star.png")
const BUNNY_THIRSTY = preload("res://assets/textures/bunny/bunny_thirsty.png")
const BUNNY_TONGUE = preload("res://assets/textures/bunny/bunny_tongue.png")
const BUNNY_WHISTLE = preload("res://assets/textures/bunny/bunny_whistle.png")
const BUNNY_YES = preload("res://assets/textures/bunny/bunny_yes.png")

const happy_textures = [BUNNY_HAPPY, BUNNY_CONTENT, BUNNY_STAR, BUNNY_YES]
const negative_textures = [BUNNY_SAD, BUNNY_SAD_2, BUNNY_SCARED, BUNNY_DEPRESSED, BUNNY_DISSAPOINTED, BUNNY_SCARED, BUNNY_HELP]
const neutral_textures = [BUNNY_QUESTION, BUNNY_APATHETIC, BUNNY_SLEEP, BUNNY_WHISTLE, BUNNY_SAS]

var rng = RandomNumberGenerator.new()

func is_happy(texture: Texture2D) -> bool:
	return texture in happy_textures
	
func is_negative(texture: Texture2D) -> bool:
	return texture in negative_textures

func pick_emotion(happiness: int) -> Texture2D:
	var texture
	if happiness < Global.SAD_LEVEL:
		texture = pick_random_negative()
	elif happiness < Global.NEUTRAL_LEVEL:
		texture = neutral_textures[rng.randi_range(0, len(neutral_textures) - 1)]
	else:
		texture = pick_random_happy()
	
	return texture

	
func pick_random_negative() -> Texture2D:
	return negative_textures[rng.randi_range(0, len(negative_textures) - 1)]


func pick_random_happy() -> Texture2D:
	return happy_textures[rng.randi_range(0, len(happy_textures) - 1)]

#enum {
	#HAPPY,
	#ANGRY,
	#DEATH,
	#HEART_EYES,
	#HELP,
	#KISS,
	#LOVE,
	#SAD,
	#STAR,
	#TONGUE,
	#YES,
	#NO
#}
