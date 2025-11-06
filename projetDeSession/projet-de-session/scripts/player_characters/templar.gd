extends Node2D

@onready var player: GenericPlayer = $GenericPlayer

func _ready() -> void:
	player.playerClass = "Templar"
	player.highlight_type = "HighlightTemplar"
	player.speed = 250.0
	player.hp = 100
	player.controlled_by = "P1"

func _physics_process(_delta: float) -> void:
	player.get_movement_input()
	
