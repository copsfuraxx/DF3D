extends NavigationMeshInstance
class_name Region

var region_x:int
var region_y:int
var block_size:int
var full:bool = true
var region_visible:bool = true

func set_region_visible(value:bool):
	region_visible = value
	for c in get_children():
		c.set_block_visible(value)
