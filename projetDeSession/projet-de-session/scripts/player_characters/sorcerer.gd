extends Node2D

@onready var player: GenericPlayer = $GenericPlayer

func _ready() -> void:
	player.playerClass = "sorcerer"
	player.speed = 200.0
	player.hp = 100
	player.controlled_by = "AI"

func _physics_process(_delta: float) -> void:
	player.get_movement_input()
