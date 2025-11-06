extends Node2D

@onready var player: GenericPlayer = $GenericPlayer

func _ready() -> void:
	player.playerClass = "Knight"
	player.highlight_type = "HighlightKnight"
	player.speed = 300.0
	player.hp = 200
	player.controlled_by = "P2"

func _physics_process(_delta: float) -> void:
	player.get_movement_input()
