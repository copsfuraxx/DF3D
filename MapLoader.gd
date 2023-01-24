extends Node

signal progress(value)

var thread
var json

var map_scene = preload("res://Map.tscn")
var niveau_scene = preload("res://Niveau.tscn")
var region_scene = preload("res://Region.tscn")
var block_scene = preload("res://Block/Block.tscn")
var rampe_scene = preload("res://Block/Rampe.tscn")
var map:Map
var niveau:Niveau
var region:Region
var block:Block
var progress:float

export(NodePath) var world
export(NodePath) var loading

func _ready():
	world = get_node(world)
	loading = get_node(loading)
	connect("progress", loading, "progress")

func _process(_delta):
	if thread == null:
		thread = Thread.new()
		thread.start(self, "init_map", null)
	elif thread.is_active() and not thread.is_alive():
		thread.wait_to_finish()
		queue_free()

func init_map(_param):
	var file = File.new()
	file.open("res://map.json", File.READ)
	json = JSON.parse(file.get_as_text()).result
	file.close()
	progress = 1 / float(json.niv_size * json.region_size * json.region_size) * 100
	map = map_scene.instance()
	map.niv_size = json.niv_size
	map.translation.x -= (json.region_size * json.block_size) / 3
	map.translation.z = map.translation.x
	# warning-ignore:integer_division
	map.translation.y -= map.niv_size / 2
	world.call_deferred("add_child", map)
	initNiv()

func initNiv():
	for i in range(json.niv_size - 1, -1, -1):
		niveau = niveau_scene.instance()
		niveau.name += str(i)
		niveau.niveau = i
		niveau.translation.y = i
		niveau.region_size = json.region_size
		map.call_deferred("add_child", niveau)
		
		initRegion()

func initRegion():
	for i in range(json.region_size):
		for j in range(json.region_size):
			region = region_scene.instance()
			region.name += str(i) + '_' + str(j)
			region.region_x = i
			region.region_y = j
			region.block_size = json.block_size
			region.translation.x = i * niveau.region_size
			region.translation.z = j * niveau.region_size
			region.set_region_visible(niveau.niv_visible)
			niveau.call_deferred("add_child", region)
			region.call_deferred("bake_navigation_mesh", false)
			if not region.full: niveau.full = false
			
			initBlock()
			emit_signal("progress", progress)

func initBlock():
	for i in range(json.block_size):
		for j in range(json.block_size):
			var idBlock = json.map[niveau.niveau][json.block_size * region.region_x + i]\
			[json.block_size * region.region_y + j]
			if idBlock != -1:
				if idBlock == 0:
						block = block_scene.instance()
				if idBlock == 1:
						block = rampe_scene.instance()
				block.name += str(i) + '_' + str(j)
				block.translation.x = i
				block.translation.z = j
				block.set_block_visible(region.region_visible)
				region.call_deferred("add_child", block)
			else: region.full = false
