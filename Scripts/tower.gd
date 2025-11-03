class_name Tower
extends Node2D

var enemies: Array = []
signal bullet_shot(pos: Vector2, direction: float, 
		bullet_enum: Data.Bullet)

func _on_detection_range_area_entered(area: Area2D) -> void:
	# add enemy once to our array
	if area not in enemies:
		enemies.append(area)


func _on_detection_range_area_exited(area: Area2D) -> void:
	if area in enemies:
		enemies.erase(area)
