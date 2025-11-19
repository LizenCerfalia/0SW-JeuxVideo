extends Node2D

@onready var enemy : GenericEnemy = $GenericEnemy

func _ready() -> void:
	enemy.hp = 150
	enemy.speed = 150.0
	enemy.damage = 20
