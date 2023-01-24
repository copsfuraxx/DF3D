extends Node

func _ready():
	var mjm = MapJsonMaker.new()
	mjm.generate()
