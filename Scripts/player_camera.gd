extends Camera2D

@export var acceleration: float = 0.35

var drag: bool

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 2:
		drag = event.pressed
	
	if event is InputEventMouseMotion:
		if drag:
			position -= event.relative * acceleration
	
