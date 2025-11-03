extends Area2D

var direction: Vector2
var speed: int = 300

func _process(delta: float) -> void:
	position += direction * speed * delta


func setup(pos, angle, _bullet_enum) -> void:
	position = pos
	direction = Vector2.DOWN.rotated(angle)
	rotation = angle
