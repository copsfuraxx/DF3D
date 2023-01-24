extends Camera

export(float) var speed = 20.0
var canMove = false

func _process(delta):
	if not canMove: return
	var move:Vector3 = Vector3.ZERO
	if Input.is_action_pressed("Left"):
		move.x -= 1
	if Input.is_action_pressed("Right"):
		move.x += 1
	if Input.is_action_pressed("Down"):
		move.z += 1
	if Input.is_action_pressed("Up"):
		move.z -= 1
	if Input.is_physical_key_pressed(KEY_R):
		move.y += 1
	if Input.is_physical_key_pressed(KEY_F):
		move.y -= 1
	move = move.normalized()
	move = move.rotated(Vector3.UP, rotation.y)
	if move != Vector3.ZERO:
		translation += move * speed * delta
	
	var r = .0
	if Input.is_action_pressed("Turn_Left"):
		r += PI/2
	if Input.is_action_pressed("Turn_Right"):
		r -= PI/2
	if r != .0:
		rotation.y += r * delta

func up():
	translation.y += 1.0

func down():
	translation.y -= 1.0
