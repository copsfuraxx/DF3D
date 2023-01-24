extends Spatial
class_name Niveau

var niveau:int
var region_size:int
var niv_visible:bool = true
var full:bool = true

func set_niv_visible(value:bool):
	niv_visible = value
	for c in get_children():
		c.set_region_visible(value)
