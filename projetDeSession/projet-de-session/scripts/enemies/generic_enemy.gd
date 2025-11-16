class_name GenericEnemy
extends CharacterBody2D

@onready var players = get_tree().get_nodes_in_group("players")
@onready var animationTree : AnimationTree = $AnimationTree
var playerEnmity = [10, 0, 0, 0]
var currentTarget

var hp : int
var speed : float
var damage : int

func is_enemy() -> bool:
	return true

func _physics_process(_delta: float) -> void:
	get_target()
	var direction = (currentTarget.global_position - global_position).normalized()
	velocity = direction * speed
	animationTree.set("parameters/Drive/blend_position", direction)
	
	move_and_slide()
	
func get_target() -> void:
	currentTarget = players[0]
	var i = 0
	for player in players:
		if playerEnmity[i] > playerEnmity[i - 1]:
			currentTarget = player
		i = i + 1
