extends Block

const FRONT = [.0, Vector3(0, 0, 0)]
const BACK = [PI, Vector3(-1, 0, -1)]
const LEFT = [PI/2, Vector3(0, 0, -1)]
const RIGHT = [-PI/2, Vector3(-1, 0, 0)]

var orientation

func _ready():
	$MeshInstance.mesh = preload("res://Block/Rampe/rampe_terre_mesh.tres")
	if (haveAllVoisin()):
		set_block_visible(false)
	popAllVoisin()

func setRotation(dir:int):
	match dir:
		0:
			orientation = LEFT
		1:
			orientation = FRONT
		2:
			orientation = RIGHT
		3:
			orientation = BACK
		_:
			orientation = FRONT
	$MeshInstance.rotation.y = orientation[0]
	$CollisionShape.rotation.y = orientation[0]
	$MeshInstance.translation = orientation[1]
	$CollisionShape.translation = orientation[1]
