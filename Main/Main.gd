extends Node

var wall_dim_x = 60
var wall_dim_y = 63
var screen_size
var rng = RandomNumberGenerator.new()

func addWallPiece(x, y):
	var WallBlock = load("res://Wall/Wall.tscn").instance()
	WallBlock.set_position(Vector2(x, y))
	WallBlock.set_name("WallBlock_"+str(x)+"-"+str(y))
	add_child(WallBlock)

func generate2dMap(width, height):
	var max_x_blocks = (width / wall_dim_x) + 1
	var max_y_blocks = (height / wall_dim_y) + 1
	var map = []
	for y in range(max_y_blocks):
		var level = [1]
		for x in range(max_x_blocks - 2):
			if y == 0 or y == max_y_blocks - 1 or y == max_y_blocks:
				level.append(1)
			elif (y == 1 or y == 2) and (x == 1 or x == 2):
				level.append(0)
			else:
				level.append(rng.randi_range (0,1))
		level.append(1)
		map.append(level)
	return map

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	screen_size = get_viewport().size
	var map = generate2dMap(screen_size[0], screen_size[1])
	var x_coord = 0
	var y_coord = 0
	for y in map:
		for x in y:
			if x == 1:
				print(str(x_coord) + ", " + str(y_coord))
				addWallPiece(x_coord, y_coord)
			x_coord += wall_dim_x
		x_coord = 0
		y_coord += wall_dim_y

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
