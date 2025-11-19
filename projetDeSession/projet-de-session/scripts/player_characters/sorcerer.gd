extends Node2D

@onready var player: GenericPlayer = $GenericPlayer

func _ready() -> void:
	player.playerClass = "Sorcerer"
	player.highlight_type = "HighlightSorcerer"
	player.speed = 200.0
	player.hp = 100
	player.controlled_by = "AI"

func _physics_process(_delta: float) -> void:
	player.get_movement_input()

func ability_1():
	pass
	
func ability_2():
	pass

func ability_3():
	pass

func ability_4():
	pass
