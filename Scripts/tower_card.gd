extends Button

signal on_pressed(tower_enum: Data.Tower)

var id: Data.Tower = Data.Tower.BASIC
var cost: int


func _ready() -> void:
	cost = Data.TOWER_DATA[Data.Tower.BASIC]["cost"]
	toggle_active(Data.money)

func toggle_active(money: int) -> void:
	disabled = cost > money
 

func setup(new_id: Data.Tower) -> void:
	id = new_id
	$VBoxContainer/Control/VBoxContainer/TowerNameLabel.text = Data.TOWER_DATA[id]['name']
	$VBoxContainer/Control/VBoxContainer/TowerCostLabel.text = str(Data.TOWER_DATA[id]['cost'])
	$VBoxContainer/TowerPreview/TextureRect.texture = load(Data.TOWER_DATA[id]['thumbnail'])

func _on_pressed() -> void:
	on_pressed.emit(id)
	
