class_name MapJsonMaker

const Voisin = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]

func generate():
	var file = File.new()
	file.open("res://map.json", File.WRITE)
	file.store_line("{")
	file.store_line("\t\"niv_size\": " + str(3) + ",")
	file.store_line("\t\"region_size\": "  + str(6) + ",")
	file.store_line("\t\"block_size\": " + str(10) + ",")
	var map = []
	var nivNotFull = []
	for niv in range(3):
		map.append([])
		for i in range(60):
			map[niv].append([])
			for _j in range(60):
				map[niv][i].append(-1)
	var noise = OpenSimplexNoise.new()
	var hauteur = []
	for i in range(60):
		hauteur.append([])
		for j in range(60):
			var f = noise.get_noise_2d(i,j)
			var v = round((f + 1) * 2)
			hauteur[i].append(v)
	for niv in range(3):
		for i in range(60):
			for j in range(60):
				if niv <= hauteur[i][j]:
					map[niv][i][j] = 0
				else:
					map[niv][i][j] = -1
					if not nivNotFull.has(niv):
						nivNotFull.append(niv)
	print(nivNotFull)
	for niv in nivNotFull:
		for i in range(60):
			for j in range(60):
				if map[niv][i][j] == -1:
					var cb = 0
					for v in Voisin:
						var v2 = Vector2(i, j) + v
						if (v2.x < 60 and v2.x >= 0 and v2.y < 60 and v2.y >= 0) and \
						   (map[niv][v2.x][v2.y] == 0): cb += 1
					if cb > 0: map[niv][i][j] = 1
	file.store_line("\t\"map\": ")
	file.store_line("\t[")
	for niv in range(3):
		file.store_line("\t\t[")
		for i in range(60):
			file.store_string("\t\t\t" + str(map[niv][i]))
			if i < 59: file.store_line(",")
			else: file.store_line("")
		file.store_string("\t\t]")
		if niv < 2: file.store_line(",")
		else: file.store_line("")
	file.store_line("\t]")
	file.store_line("}")
	print("fin")
