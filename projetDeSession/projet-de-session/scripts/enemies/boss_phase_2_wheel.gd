extends CharacterBody2D

@onready var head = get_tree().get_first_node_in_group("enemies")
@onready var players = get_tree().get_nodes_in_group("players")
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
var playerEnmity = [0, 0, 0, 0] # templar, assassin, knight, sorcerer, selon l'order de generation dans l'arbre
var currentTarget

var hp = 1000
var speed = 100
var damage = 100

func _ready() -> void:
	animationPlayer.play("Spinning")

func is_enemy() -> bool:
	return true

func _physics_process(delta: float) -> void:
	if (hp < 0):
		handle_death()
	
	get_target()
	var direction = (currentTarget.global_position - global_position).normalized()
	velocity = direction * speed
	
	move_and_collide(velocity * delta)
	
func get_target() -> void:
	currentTarget = players[0]
	var i = 0
	var highestEmnityTarget = playerEnmity[0]
	for player in players:
		if playerEnmity[i] > highestEmnityTarget:
			currentTarget = player
			highestEmnityTarget = playerEnmity[i]
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
			
func lose_emnity(caster: String) -> void:
	match caster:
		"Templar":
			playerEnmity[0] = 0
		"Assassin":
			playerEnmity[1] = 0
		"Knight":
			playerEnmity[2] = 0
		"Sorcerer":
			playerEnmity[3] = 0
			
func handle_death():
	head.animationPlayer.speed_scale += 0.50
	head.hp -= 2000
	head.speed += 50
	head.damage += 50
	queue_free()

func _on_auto_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("is_player") && body == currentTarget:
		body.handle_hurt(damage)

func _on_auto_attack_delay_timeout() -> void:
	$AutoAttackRange/CollisionShape2D.disabled = !$AutoAttackRange/CollisionShape2D.disabled
