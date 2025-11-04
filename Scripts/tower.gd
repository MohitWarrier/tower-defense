class_name Tower
extends Node2D


signal bullet_shot(pos: Vector2, direction: float, 
		bullet_enum: Data.Bullet)
signal tower_clicked(tower: Tower)

var enemies: Array = []
var type: Data.Tower

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
		tower_clicked.emit(self)
