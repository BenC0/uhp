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
	var max_x_blocks = ceil(width / wall_dim_x)
	var max_y_blocks = ceil(height / wall_dim_y)
	var map = []
	for y in range(max_y_blocks):
		# first column is always a block
		var level = [1]
		for x in range(max_x_blocks):
			var block 
			# if first or last row, or first column, set to block
			if y == 0 or y >= max_y_blocks - 1 or x == 0:
				block = 1
			else:
				block = 0
			level.append(block)
			print(str(x) + ", " + str(y) + ", " + str(max_y_blocks))
		map.append(level)
	return map

func generate_level(map):
	var x_coord = 0
	var y_coord = 0
	for y in map:
		for x in y:
			if x == 1:
				addWallPiece(x_coord, y_coord)
			x_coord += wall_dim_x
		x_coord = 0
		y_coord += wall_dim_y

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	screen_size = get_viewport().size
	#var map = generate2dMap(screen_size[0], screen_size[1])
	#generate_level(map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
