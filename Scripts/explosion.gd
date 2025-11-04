extends Sprite2D

func setup(pos) -> void: 
	position = pos
	$AnimationPlayer.play("Explosion")


func hit_enemies() -> void:
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if position.distance_to(enemy.global_position) < 50:
			enemy.hit(3)
