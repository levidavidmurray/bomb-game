extends Node2D

var tilemap: TileMap

func set_bomb(world_coords: Vector2) -> void:
	print("Bomb set: world %s tilemap %s" % [
		world_coords,
		tilemap.world_to_map(world_coords)
	])
	yield(get_tree().create_timer(1.5), "timeout")
	print("...BADA BOOM!!")
