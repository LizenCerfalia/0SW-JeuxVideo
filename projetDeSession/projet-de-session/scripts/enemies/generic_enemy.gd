extends CharacterBody2D

@onready var players = get_tree().get_nodes_in_group("players")
var playerEnmity = [0, 0, 0, 10]
var currentTarget

const SPEED = 2.0


func is_enemy() -> bool:
	return true

func _physics_process(_delta: float) -> void:
	get_target()
	global_position = global_position.move_toward(currentTarget.global_position, SPEED)
	
	move_and_slide()
	
func get_target() -> void:
	currentTarget = players[0]
	var i = 0
	for player in players:
		if playerEnmity[i] > playerEnmity[i - 1]:
			currentTarget = player
		i = i + 1
