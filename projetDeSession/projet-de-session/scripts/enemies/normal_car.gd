extends Node2D

@onready var enemy : GenericEnemy = $GenericEnemy

func _ready() -> void:
	enemy.hp = 300
	enemy.speed = 100.0
	enemy.damage = 30
