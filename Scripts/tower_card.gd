extends Button

signal on_pressed(tower_enum: Data.Tower)

var id: Data.Tower = Data.Tower.BASIC
var cost: int


func _ready() -> void:
	cost = Data.TOWER_DATA[Data.Tower.BASIC]["cost"]
	toggle_active(Data.money)

func toggle_active(money: int) -> void:
	disabled = cost > money
 

func _on_pressed() -> void:
	on_pressed.emit(id)
	
