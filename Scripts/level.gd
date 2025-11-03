extends Node2D

var enemy_scene: PackedScene = preload("res://Scenes/enemy.tscn")
var bullet_scene: PackedScene = preload("res://Scenes/bullet.tscn")
var place_tower: bool:
	set(value):
		place_tower = value
		$Background/TowerPreview.visible = value
var selected_tower: Data.Tower
var tower_scenes = {
	Data.Tower.BASIC: "res://Scenes/tower_basic.tscn"
}
var used_cells: Array[Vector2i]

func _ready() -> void:
	RenderingServer.set_default_clear_color("bdf6f5ff")
	

func _input(event: InputEvent) -> void:
	
	var raw_pos = get_local_mouse_position()
	var pos = Vector2i(raw_pos.x / 16, raw_pos.y / 16)
	
	if event is InputEventMouseButton and event.button_mask == 1 and place_tower:
			var tile_data = $Background/TileMapLayer.get_cell_tile_data(pos) as TileData
			# check if tower is placable in selected spot.
			# we used custom data layer painting in tilemaplayer
			# it should belong to the Usable layer and not be an null, be a TileData type
			if event.button_index == 1 and pos not in used_cells and tile_data is TileData and tile_data.get_custom_data('Usable'):
				used_cells.append(pos)
				var tower = load(tower_scenes[selected_tower]).instantiate()
				tower.position = pos * 16 + Vector2i(8,8)
				tower.connect('bullet_shot', _on_bullet_shot)
				$Towers.add_child(tower)
				place_tower = false
				Data.money -= Data.TOWER_DATA[selected_tower]['cost']

	# place tower preview texture on mouse cursor position
	if event is InputEventMouseMotion and place_tower:
		var tower_pos = pos * 16 + Vector2i(8,8) # 16 is tile size
		$Background/TowerPreview.position = tower_pos
		
	# player can cancel tower placing
	if Input.is_action_just_pressed("Exit"):
		place_tower = false

func _on_bullet_shot(pos: Vector2, angle: float, 
		bullet_enum: Data.Bullet) -> void:

	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.setup(pos, angle, bullet_enum)
	$Bullets.add_child(bullet_instance)
	

# tower preview when selected
func _on_ui_tower_selected(tower_type: Data.Tower) -> void:
	place_tower = true
	selected_tower = tower_type
	$Background/TowerPreview.texture = \
	load(Data.TOWER_DATA[tower_type]["thumbnail"])


func _on_ui_wave_started() -> void:
	var wave = Data.ENEMY_WAVES[Data.current_wave]
	Data.current_wave += 1
	# get all enemies in wave 
	for enemy_type in wave:
		# amount of each enemy type
		for i in wave[enemy_type]:
			var path_follow = PathFollow2D.new()
			var enemy = enemy_scene.instantiate()
			enemy.setup(path_follow, enemy_type)
			path_follow.add_child(enemy)
			$Path.add_child(path_follow)
			await get_tree().create_timer(1).timeout
	
	
	
