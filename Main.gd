extends Node2D

export var columns = 16
export var rows = 12
export var tile_map_offset = 32

var cell_size = 64
var starting_coords = []
var BombScene = preload("res://Bomb.tscn")

var _tileset

func _ready():
	GameManager.tilemap = $TileMap
	print($TileMap.get_used_cells().size())
	_tileset = $TileMap.get_tileset()
	$TileMap.z_index = -1
	print("%s, %s" % [z_index, $TileMap.z_index])
	z_index = 10
	print(_tileset)
	for y in range(rows):
		for x in range(columns):
			if y == 0 || y == rows-1:
				if x == 0 || x == columns-1:
					print("Set corner on (%s, %s) world: %s" % [x, y, coords_to_world(x, y)])
					print("world_to_map: %s" % $TileMap.world_to_map(coords_to_world(x, y)))
					$TileMap.set_cellv(
						Vector2(x, y), 
						2, 
						x == columns-1,
						y == rows-1
					)
				else:
					$TileMap.set_cellv(Vector2(x, y), 0)
			else:
				$TileMap.set_cellv(Vector2(x, y), 0)
			starting_coords.append(coords_to_world(x, y))
			
	init_signals()
	pass # Replace with function body.
	
func _process(delta):
	pass
		
func init_signals():
	for child in $Players.get_children():
		(child as Player).connect("set_bomb", self, "set_bomb")
		
func coords_to_world(x, y) -> Vector2:
	var world_x = tile_map_offset + ((x) * cell_size)
	var world_y = tile_map_offset + ((y) * cell_size)
	return Vector2(world_x, world_y)
		
func set_bomb(player_id, world_pos):
	var bomb = BombScene.instance()
	var mapped_world_pos = $TileMap.map_to_world($TileMap.world_to_map(world_pos))
	mapped_world_pos.x += tile_map_offset
	mapped_world_pos.y += tile_map_offset
	bomb.position = mapped_world_pos
	$Bombs.add_child(bomb)
	print("Set bomb")
	yield(get_tree().create_timer(1.5), "timeout")
	print("BOOM!")
	bomb.queue_free()

