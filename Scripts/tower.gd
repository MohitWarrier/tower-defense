class_name Tower
extends Node2D


signal bullet_shot(pos: Vector2, direction: float, 
		bullet_enum: Data.Bullet)
signal tower_clicked(tower: Tower)

var enemies: Array = []
var type: Data.Tower
var upgraded: bool
var bullet_type: Data.Bullet
var cost: int
var upgrade_cost: int

func setup(tower_type: Data.Tower) -> void:
	$ReloadTimer.wait_time = Data.TOWER_DATA[tower_type]['reload_time']
	$TowerMenu.cost = Data.TOWER_DATA[tower_type]['upgrade_cost']
	bullet_type = Data.TOWER_DATA[tower_type]['bullet']
	cost = Data.TOWER_DATA[tower_type]['cost']
	upgrade_cost = Data.TOWER_DATA[tower_type]['upgrade_cost']
	type = tower_type

func _on_detection_range_area_entered(area: Area2D) -> void:
	# add enemy once to our array
	if area not in enemies:
		enemies.append(area)


func _on_detection_range_area_exited(area: Area2D) -> void:
	if area in enemies:
		enemies.erase(area)


func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	
	# button mask 1 is pressing button, 0 is releasing
	if event is InputEventMouseButton and event.button_index == 1 and event.button_mask == 1:
		if not $DelayTimer.time_left:
			tower_clicked.emit(self)
			$TowerMenu.reveal(upgraded)


func _on_tower_menu_upgrade_pressed() -> void:
	Data.money -= Data.TOWER_DATA[type]['upgrade_cost']
	tower_upgrade()
	$TowerMenu.hide()
	upgraded = true
	

func tower_upgrade() -> void:
	pass


# player can sell tower for 70% of its total cost
func _on_tower_menu_sell_pressed() -> void:
	var refund = cost if not upgraded else cost + upgrade_cost
	Data.money += refund * 0.7
	queue_free()
	

func hide_ui() -> void:
	$TowerMenu.hide()
	
	
