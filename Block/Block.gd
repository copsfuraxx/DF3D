extends StaticBody
class_name Block

signal pop

const voisin = [Vector3(.5,-.5,-.5), Vector3(-1.5, -.5, -.5), Vector3(-.5, .5, -.5),\
				Vector3(-.5, -1.5, -.5), Vector3(-.5, -.5, .5), Vector3(-.5, -.5, -1.5)]

var block_name = "Terre"
var block_x:int
var block_y:int

func _ready():
	$MeshInstance.mesh = preload("res://Block/TerreMesh.tres")
	if (haveAllVoisin()):
		set_block_visible(false)
	popAllVoisin()

func set_block_visible(value:bool):
	$MeshInstance.visible = value

func haveAllVoisin():
	var space_state = get_world().direct_space_state
	for v in voisin:
		var result = space_state.intersect_ray(global_translation - Vector3(.5, .5, .5), global_translation + v, [self])
		if result.empty() or !result.collider.is_in_group("block"):
			return false
	return true

func popAllVoisin():
	var space_state = get_world().direct_space_state
	for v in voisin:
		var result = space_state.intersect_ray(global_translation - Vector3(.5, .5, .5), global_translation + v, [self])
		if !result.empty() and result.collider.is_in_group("block"):
			connect("pop", result.collider, "blockPop")
	emit_signal("pop")
	disconnectPop()

func disconnectPop():
	for s in get_signal_connection_list("pop"):
		disconnect("pop", s.target, "blockPop")

func blockPop():
	if (haveAllVoisin()):
		set_block_visible(false)
