extends Node2D

const TILE_SIZE := 16
const MAP_W := 40
const MAP_H := 25
const FLOOR_TEX := "res://assets/environment/tilesets/Floors_Tiles.png"
const WALL_TEX := "res://assets/environment/tilesets/Wall_Tiles.png"

func _ready() -> void:
	_build_tilemap()
	_setup_camera_limits()


func _build_tilemap() -> void:
	var tileset := TileSet.new()
	tileset.tile_size = Vector2i(TILE_SIZE, TILE_SIZE)

	# --- 地板图集 ---
	var floor_source := TileSetAtlasSource.new()
	var floor_tex := load(FLOOR_TEX) as Texture2D
	floor_source.texture = floor_tex
	floor_source.texture_region_size = Vector2i(TILE_SIZE, TILE_SIZE)
	var floor_cols := floor_tex.get_width() / TILE_SIZE
	var floor_rows := floor_tex.get_height() / TILE_SIZE
	for x in range(floor_cols):
		for y in range(floor_rows):
			floor_source.create_tile(Vector2i(x, y))
	var floor_id := tileset.add_source(floor_source)

	# --- 墙壁图集 ---
	var wall_source := TileSetAtlasSource.new()
	var wall_tex := load(WALL_TEX) as Texture2D
	wall_source.texture = wall_tex
	wall_source.texture_region_size = Vector2i(TILE_SIZE, TILE_SIZE)
	var wall_cols := wall_tex.get_width() / TILE_SIZE
	var wall_rows := wall_tex.get_height() / TILE_SIZE
	for x in range(wall_cols):
		for y in range(wall_rows):
			wall_source.create_tile(Vector2i(x, y))
	var wall_id := tileset.add_source(wall_source)

	# --- 地板层 ---
	var floor_layer := TileMapLayer.new()
	floor_layer.name = "Floor"
	floor_layer.tile_set = tileset
	add_child(floor_layer)

	var rng := RandomNumberGenerator.new()
	rng.randomize()
	for x in range(MAP_W):
		for y in range(MAP_H):
			# 从图集前几行随机选地板瓦片，产生纹理变化
			var tile_x := rng.randi_range(0, floor_cols - 1)
			var tile_y := rng.randi_range(0, mini(4, floor_rows - 1))
			floor_layer.set_cell(Vector2i(x, y), floor_id, Vector2i(tile_x, tile_y))

	# --- 墙壁层（仅边框）---
	var wall_layer := TileMapLayer.new()
	wall_layer.name = "Walls"
	wall_layer.tile_set = tileset
	add_child(wall_layer)

	# 顶边和底边
	for x in range(MAP_W):
		wall_layer.set_cell(Vector2i(x, 0), wall_id, Vector2i(x % wall_cols, 0))
		wall_layer.set_cell(Vector2i(x, MAP_H - 1), wall_id, Vector2i(x % wall_cols, 0))
	# 左边和右边
	for y in range(MAP_H):
		wall_layer.set_cell(Vector2i(0, y), wall_id, Vector2i(0, 0))
		wall_layer.set_cell(Vector2i(MAP_W - 1, y), wall_id, Vector2i(0, 0))

	# --- 不可见碰撞墙 ---
	_create_boundary_walls()

	# 确保玩家渲染在瓦片之上
	$Player.z_index = 10


func _create_boundary_walls() -> void:
	var map_w_px := MAP_W * TILE_SIZE
	var map_h_px := MAP_H * TILE_SIZE

	_add_wall(Vector2(map_w_px / 2, -TILE_SIZE), Vector2(map_w_px + TILE_SIZE * 4, TILE_SIZE * 2))  # 上
	_add_wall(Vector2(map_w_px / 2, map_h_px + TILE_SIZE), Vector2(map_w_px + TILE_SIZE * 4, TILE_SIZE * 2))  # 下
	_add_wall(Vector2(-TILE_SIZE, map_h_px / 2), Vector2(TILE_SIZE * 2, map_h_px + TILE_SIZE * 4))  # 左
	_add_wall(Vector2(map_w_px + TILE_SIZE, map_h_px / 2), Vector2(TILE_SIZE * 2, map_h_px + TILE_SIZE * 4))  # 右


func _add_wall(pos: Vector2, size: Vector2) -> void:
	var body := StaticBody2D.new()
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = size
	shape.shape = rect
	body.add_child(shape)
	body.position = pos
	add_child(body)


func _setup_camera_limits() -> void:
	var cam := $Player/Camera2D as Camera2D
	cam.limit_left = 0
	cam.limit_top = 0
	cam.limit_right = MAP_W * TILE_SIZE
	cam.limit_bottom = MAP_H * TILE_SIZE
