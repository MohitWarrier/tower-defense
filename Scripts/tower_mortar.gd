extends Tower


func show_crosshair() -> void:
	$CrosshairSprite.show()
	

func crosshair_pos_update(pos: Vector2i) -> void:
	$CrosshairSprite.global_position = pos


func finished_placing() -> void:
	$CrosshairSprite.hide()


func _on_reload_timer_timeout() -> void:
	$ShootAnimation.show()
	$ShootAnimation.play("default")
	# create explosion around the crosshair
	await $ShootAnimation.animation_finished
	bullet_shot.emit($CrosshairSprite.global_position, 0, bullet_type)


func tower_upgrade() -> void:
	$Base.texture = load("res://graphics/towers/mortar/mortar tower upgrade down.png")
