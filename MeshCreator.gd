tool
extends Spatial

#func _ready():
#	# Initialiser le ArrayMesh.
#	var arr_mesh = ArrayMesh.new()
#	var arrays = []
#	arrays.resize(ArrayMesh.ARRAY_MAX)
#	var vertices = PoolVector3Array()
#	vertices.push_back(Vector3(0, 0, 0))
#	vertices.push_back(Vector3(-1, 0, 0))
#	vertices.push_back(Vector3(-1, -1, -1))
#
#	vertices.push_back(Vector3(0, 0, -1))
#	vertices.push_back(Vector3(0, 0, 0))
#	vertices.push_back(Vector3(-1, -1, -1))
#
#	vertices.push_back(Vector3(-1, -1, -1))
#	vertices.push_back(Vector3(-1, 0, 0))
#	vertices.push_back(Vector3(-1, -1, 0))
#
#	vertices.push_back(Vector3(-1, -1, 0))
#	vertices.push_back(Vector3(-1, 0, 0))
#	vertices.push_back(Vector3(0, 0, 0))
#
#	vertices.push_back(Vector3(-1, -1, 0))
#	vertices.push_back(Vector3(0, 0, 0))
#	vertices.push_back(Vector3(0, -1, 0))
#	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
#	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
#
#	$MeshInstance.mesh = arr_mesh

func _ready():
	# Initialiser le ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	var vertices = PoolVector3Array()
	var normales = PoolVector3Array()
	
	vertices.push_back(Vector3(0, 0, 0))
	vertices.push_back(Vector3(-1, -1, -1))
	vertices.push_back(Vector3(0, -1, -1))
	
	vertices.push_back(Vector3(0, 0, 0))
	vertices.push_back(Vector3(-1, 0, 0))
	vertices.push_back(Vector3(-1, -1, -1))
	
	vertices.push_back(Vector3(-1, 0, 0))
	vertices.push_back(Vector3(-1, -1, 0))
	vertices.push_back(Vector3(-1, -1, -1))
	
	vertices.push_back(Vector3(0, 0, 0))
	vertices.push_back(Vector3(0, -1, -1))
	vertices.push_back(Vector3(0, -1, 0))
	
	vertices.push_back(Vector3(0, 0, 0))
	vertices.push_back(Vector3(0, -1, 0))
	vertices.push_back(Vector3(-1, 0, 0))
	
	vertices.push_back(Vector3(-1, 0, 0))
	vertices.push_back(Vector3(0, -1, 0))
	vertices.push_back(Vector3(-1, -1, 0))
	
	vertices.push_back(Vector3(0, -1, -1))
	vertices.push_back(Vector3(-1, -1, -1))
	vertices.push_back(Vector3(-1, -1, 0))
	
	vertices.push_back(Vector3(0, -1, -1))
	vertices.push_back(Vector3(-1, -1, 0))
	vertices.push_back(Vector3(0,-1,0))
	
	for i in range(0, vertices.size(), 3):
		var va = vertices[i + 1] - vertices[i]
		var vb = vertices[i + 2] - vertices[i]
		var v = vb.cross(va)
		v.normalized()
		normales.push_back(v)
		normales.push_back(v)
		normales.push_back(v)
	
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_NORMAL] = normales
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	$MeshInstance.mesh = arr_mesh
