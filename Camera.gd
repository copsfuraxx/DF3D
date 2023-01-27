extends Camera

export(float) var speed = 20.0
var canMove = false

var mouse
var timer =.0

func _process(delta):
	if timer > .0 : timer -= delta
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

	if Input.is_action_pressed("Left_click") and timer <= .0:
		var space_state = get_world().direct_space_state
		var to = global_translation + project_ray_normal(mouse) * 100
		var result = space_state.intersect_ray(global_translation, to)
		result.collider.queue_free()
		timer = .5

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		mouse = event.global_position

func up():
	translation.y += 1.0

func down():
	translation.y -= 1.0
