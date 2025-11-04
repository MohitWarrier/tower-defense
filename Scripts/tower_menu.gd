extends Control

signal upgrade_pressed
signal sell_pressed

var cost: int = 100

func _ready() -> void:
	toggle_active(Data.money)
	$UpgradeButton.text = 'Upgrade ' + str(cost)
	

func _on_upgrade_button_pressed() -> void:
	upgrade_pressed.emit()


func reveal(upgraded) -> void:
	show()
	if upgraded:
		$UpgradeButton.hide()

func toggle_active(money: int) -> void:
	$UpgradeButton.disabled = cost > money

func _on_sell_button_pressed() -> void:
	sell_pressed.emit()
