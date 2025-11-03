extends Tower


func _on_reload_timer_timeout() -> void:
	if enemies.size() > 0:
		fire_animation()
		bullet_shot.emit(position, 0, Data.Bullet.FIRE)


func fire_animation() -> void:
	for particles: GPUParticles2D in $Particles.get_children():
		particles.emitting = true
		
