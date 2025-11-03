extends CanvasLayer

signal tower_selected(tower_type: Data.Tower)
signal wave_started

enum MenuState {CLOSED, OPEN}

const MENU_BUTTON_TEXTURES = {
	MenuState.CLOSED:
	{
		'normal': "res://graphics/ui/menu.png",
		'pressed': "res://graphics/ui/menu.png",
		'hover': "res://graphics/ui/menu_hover.png"
	},
	MenuState.OPEN:
	{
		'normal': "res://graphics/ui/close_normal.png",
		'pressed': "res://graphics/ui/close_normal.png",
		'hover': "res://graphics/ui/close_hover.png"
	}
}

var current_menu_state: MenuState = MenuState.CLOSED
var tower_card_scene: PackedScene = preload("res://Scenes/tower_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_stats(Data.money, Data.health)
	change_button_texture(current_menu_state)
	$TowerCards/TowerCardsContainer.visible = current_menu_state == MenuState.OPEN
	
	for tower_enum in Data.Tower.values():
		var tower_card = tower_card_scene.instantiate()
		tower_card.setup(tower_enum)
		$TowerCards/TowerCardsContainer.add_child(tower_card)
		tower_card.connect('on_pressed', tower_select)
	
	
func tower_select(tower_type: Data.Tower) -> void:
	tower_selected.emit(tower_type)
	

func update_stats(money: int, health: int) -> void:
	$Control/StatsContainer/MoneyContainer/HBoxContainer/Label.text = str(money)
	$Control/StatsContainer/HealthContainer/HBoxContainer/Label.text = str(health)


func _on_start_wave_button_pressed() -> void:
	wave_started.emit()


func change_button_texture(state: MenuState) -> void:
	$TowerCards/MenuToggleButton.texture_normal = load(MENU_BUTTON_TEXTURES[state]['normal'])
	$TowerCards/MenuToggleButton.texture_hover = load(MENU_BUTTON_TEXTURES[state]['hover'])
	$TowerCards/MenuToggleButton.texture_pressed = load(MENU_BUTTON_TEXTURES[state]['pressed'])


func _on_menu_toggle_button_pressed() -> void:
	if current_menu_state == MenuState.OPEN:
		current_menu_state = MenuState.CLOSED
	else:
		current_menu_state = MenuState.OPEN
	
	change_button_texture(current_menu_state)
	$TowerCards/TowerCardsContainer.visible = current_menu_state == MenuState.OPEN
	
	
	
