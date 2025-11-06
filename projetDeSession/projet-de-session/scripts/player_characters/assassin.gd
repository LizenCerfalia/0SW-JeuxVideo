extends Node2D

@onready var player: GenericPlayer = $GenericPlayer

func _ready() -> void:
	player.playerClass = "Assassin"
	player.highlight_type = "HighlightAssassin"
	player.speed = 350.0
	player.hp = 150
	player.controlled_by = "AI"

func _physics_process(_delta: float) -> void:
	player.get_movement_input()
