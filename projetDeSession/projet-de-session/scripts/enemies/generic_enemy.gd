class_name GenericEnemy
extends CharacterBody2D

@onready var players = get_tree().get_nodes_in_group("players")
@onready var animationTree : AnimationTree = $AnimationTree
var playerEnmity = [0, 0, 10, 0] # templar, assassin, knight, sorcerer, selon l'order de generation dans l'arbre
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
		
func handle_emnity(caster: String, emnity: int) -> void:
	match caster:
		"Templar":
			playerEnmity[0] += emnity
		"Assassin":
			playerEnmity[1] += emnity
		"Knight":
			var knight = players[2].get_parent()
			if (knight.has_method("stance_on") && knight.stance_on):
				emnity *= 2
			playerEnmity[2] += emnity
		"Sorcerer":
			playerEnmity[3] += emnity
