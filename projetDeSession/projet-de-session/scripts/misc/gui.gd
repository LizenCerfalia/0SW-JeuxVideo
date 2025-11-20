extends MarginContainer

@onready var templarBar = $TemplarBar
@onready var assassinBar = $AssassinBar
@onready var knightBar = $KnightBar
@onready var sorcererBar = $SorcererBar

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
