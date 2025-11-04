extends Tower

func _ready() -> void:
	type = Data.Tower.MORTAR


func show_crosshair() -> void:
	$CrosshairSprite.show()
	

func crosshair_pos_update(pos: Vector2i) -> void:
	$CrosshairSprite.global_position = pos


func finished_placing() -> void:
	$CrosshairSprite.hide()
	# i want a mortar explosion immediately when tower is place
	# game design decision
	bullet_shot.emit($CrosshairSprite.global_position, 0, Data.Bullet.MORTAR_EXPLOSION)

func _on_reload_timer_timeout() -> void:
	# create explosion around the crosshair
	bullet_shot.emit($CrosshairSprite.global_position, 0, Data.Bullet.MORTAR_EXPLOSION)
