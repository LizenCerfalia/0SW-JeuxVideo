extends Node2D

@onready var enemy : GenericEnemy = $GenericEnemy

func _ready() -> void:
	enemy.hp = 400
	enemy.speed = 75.0
	enemy.damage = 50
