extends Control

export(NodePath) var camera

func _ready():
	camera = get_node(camera)

func progress(value):
	var progressBar = $CenterContainer/VBoxContainer/ProgressBar
	progressBar.value += value
	if progressBar.value >= 100:
		camera.canMove = true
		queue_free()
