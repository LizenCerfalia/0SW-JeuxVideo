extends Node2D

@onready var gui = $GUI

@onready var templarBar = $GUI/TemplarBar
@onready var assassinBar = $GUI/AssassinBar
@onready var knightBar = $GUI/KnightBar
@onready var sorcererBar = $GUI/SorcererBar

@onready var templar = $Templar
@onready var assassin = $Assassin
@onready var knight = $Knight
@onready var sorcerer = $Sorcerer

func _ready() -> void:
	gui.size = get_viewport_rect().size / 1.5
	
func hp_update(playerClass : String, value : int):
	match playerClass:
		"templar":
			templarBar.value = value
		"assassin":
			assassinBar.value = value
		"knight":
			knightBar.value = value
		"sorcerer":
			sorcererBar.value = value
		_:
			return
