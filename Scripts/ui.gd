extends CanvasLayer

signal tower_selected(tower_type: Data.Tower)
signal wave_started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TowerCards/HBoxContainer/TowerCard.connect("on_pressed", tower_select)
	$Control/StatsContainer/HealthContainer/HBoxContainer/Label.text = str(Data.health)
	$Control/StatsContainer/MoneyContainer/HBoxContainer/Label.text = str(Data.money)
func tower_select(tower_type: Data.Tower) -> void:
	tower_selected.emit(tower_type)
	

func update_stats(money: int, health: int) -> void:
	$Control/StatsContainer/MoneyContainer/HBoxContainer/Label.text = str(money)
	$Control/StatsContainer/HealthContainer/HBoxContainer/Label.text = str(health)

func _on_start_wave_button_pressed() -> void:
	wave_started.emit()
