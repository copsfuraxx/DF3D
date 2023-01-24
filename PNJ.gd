extends KinematicBody

func _ready():
	$NavigationAgent.set_target_location(Vector3(-10,0,-10))
	set_physics_process(false)

func _physics_process(_delta):
	var _v = move_and_slide(translation.direction_to($NavigationAgent.get_next_location()) * 1.0)

func _input(event):
	if event.is_action_pressed("Left_click"):
		set_physics_process(true)
