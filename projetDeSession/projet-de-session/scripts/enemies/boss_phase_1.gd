extends CharacterBody2D

@onready var players = get_tree().get_nodes_in_group("players")
@onready var animationTree : AnimationTree = $AnimationTree
var playerEnmity = [randf(), randf(), randf(), randf()]
var currentTarget

const SPEED = 100.0


func is_enemy() -> bool:
	return true

func _physics_process(_delta: float) -> void:
	get_target()
	var direction = (currentTarget.global_position - global_position).normalized()
	print(direction)
	velocity = direction * SPEED
	animationTree.set("parameters/Drive/blend_position", direction)
	
	move_and_slide()
	
func get_target() -> void:
	currentTarget = players[0]
	var i = 0
	for player in players:
		if playerEnmity[i] > playerEnmity[i - 1]:
			currentTarget = player
		i = i + 1
