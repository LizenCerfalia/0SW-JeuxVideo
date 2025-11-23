extends MarginContainer

@onready var templarBar = $TemplarBar
@onready var assassinBar = $AssassinBar
@onready var knightBar = $KnightBar
@onready var sorcererBar = $SorcererBar

func _ready() -> void:
	templarBar.value = 150
	assassinBar.value = 100
	sorcererBar.value = 150
	knightBar.value = 300
	templarBar.max_value = 150
	assassinBar.max_value = 100
	sorcererBar.max_value = 150
	knightBar.max_value = 300

func hp_update(playerClass : String, value : int):
	match playerClass:
		"Templar":
			templarBar.value = value
		"Assassin":
			assassinBar.value = value
		"Knight":
			knightBar.value = value
		"Sorcerer":
			sorcererBar.value = value
		_:
			return
