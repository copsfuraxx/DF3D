extends Block

const FRONT_LEFT = [PI, Vector3(-1, 0, -1)]
const BACK_LEFT = [-PI/2, Vector3(-1, 0, 0)]
const BACK_RIGHT = [.0, Vector3(0, 0, 0)]
const FRONT_RIGHT = [PI/2, Vector3(0, 0, -1)]

var orientation

func _ready():
	$MeshInstance.mesh = preload("res://Block/Rampe/rampe2_terre_mesh.tres")
	if (haveAllVoisin()):
		set_block_visible(false)
	popAllVoisin()

func setRotation(dir:int):
	match dir:
		0:
			orientation = FRONT_RIGHT
		1:
			orientation = BACK_LEFT
		2:
			orientation = BACK_RIGHT
		3:
			orientation = FRONT_LEFT
		_:
			orientation = FRONT_LEFT
	$MeshInstance.rotation.y = orientation[0]
	$CollisionShape.rotation.y = orientation[0]
	$MeshInstance.translation = orientation[1]
	$CollisionShape.translation = orientation[1]
