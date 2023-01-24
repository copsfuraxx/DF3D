extends Spatial
class_name Map

signal up
signal down

var niv_size:int

var niv = 1

func _ready():
	var camera = get_node("../Camera")
	var _v = connect("up", camera, "up")
	_v = connect("down", camera, "down")

func _process(_delta):
	if Input.is_action_just_released("Level_Up"):
		if niv + 1 >= niv_size: return
		niv += 1
		get_node("Niveau" + str(niv)).set_niv_visible(true)
#		emit_signal("up")
	if Input.is_action_just_released("Level_Down"):
		if get_node("Niveau" + str(niv)).full or niv - 1 < 0: return
		get_node("Niveau" + str(niv)).set_niv_visible(false)
		niv -= 1
#		emit_signal("down")
