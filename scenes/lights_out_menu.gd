extends Control

@export var rows := 3
@export var cols := 3
@export var tile_scene: PackedScene

signal puzzle_solved

var tiles = []

func _ready():
	create_grid()

func open_menu():
	visible = true
	randomize_puzzle()

func close_menu():
	visible = false
	
func create_grid():
	var grid = $CenterContainer/GridContainer
	for y in range(rows):
		tiles.append([])
		for x in range(cols):
			var tile = tile_scene.instantiate()
			tile.x = x
			tile.y = y
			
			# Set tile size (important!)
			tile.custom_minimum_size = Vector2(64, 64)
			grid.add_child(tile)

			tile.tile_pressed.connect(_on_tile_pressed)
			tiles[y].append(tile)
			
func _on_tile_pressed(x, y):
	toggle_tile(x, y)
	toggle_tile(x + 1, y)
	toggle_tile(x - 1, y)
	toggle_tile(x, y + 1)
	toggle_tile(x, y - 1)
	print_grid()
	if is_solved():
		emit_signal("puzzle_solved")
		await get_tree().create_timer(0.5).timeout
		close_menu()
		
func print_grid():
	for row in tiles:
		var _line = ""
		for tile in row:
			_line += "X " if tile.is_on else "O "
		#print(_line)
	#print("----")

func toggle_tile(x, y):
	if x < 0 or x >= cols: return
	if y < 0 or y >= rows: return
	tiles[y][x].toggle()

func is_solved() -> bool:
	# loop over all tiles and check that not are on
	for row in tiles:
		for tile in row:
			if not tile.is_on:
				return false
	return true

func randomize_puzzle():
	for i in range(10):
		var x = randi() % cols
		var y = randi() % rows
		_on_tile_pressed(x, y)


func _on_interact():
	$CanvasLayer/LightsOutMenu.open_menu()
