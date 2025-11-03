extends Area2D

var progress_speed: float
var health: int
var path_follow: PathFollow2D

func setup(new_path_follow: PathFollow2D, enemy_type: Data.Enemy) -> void:
	path_follow = new_path_follow
	health = Data.ENEMY_DATA[enemy_type]["health"]
	progress_speed = Data.ENEMY_DATA[enemy_type]["speed"]
	$Sprite2D.texture = load(Data.ENEMY_DATA[enemy_type]["texture"])
	
	# randomize position a lil bit
	position += Vector2(randi_range(-4,4),randi_range(-4,4))
	
func _process(delta: float) -> void:
	path_follow.progress_ratio += progress_speed * delta
	# enemy reached end
	if path_follow.progress_ratio >= 0.99:
		Data.health -= 1
		queue_free()
	

func _on_area_entered(bullet: Area2D) -> void:
	bullet.queue_free()
	hit(1)


func hit(damage: int) -> void:
	health -= damage
	flash()
	if health <= 0:
		Data.money += 1
		queue_free()


func flash() -> void:
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
