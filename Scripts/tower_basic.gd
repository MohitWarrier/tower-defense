extends Tower

func _process(_delta: float) -> void:
	if enemies.size() > 0:
		$Turret.look_at(enemies[0].global_position)
		# subtract 90 degrees from turret rotation as godot
		# default always looks forward, 90 degrees
		$Turret.rotation -= PI/2 # PI/2 is quarter rotation.


func _on_reload_timer_timeout() -> void:
	if enemies:
		var dir = Vector2.DOWN.rotated($Turret.rotation).normalized()
		bullet_shot.emit(position + dir * 16, $Turret.rotation, Data.Bullet.SINGLE)
