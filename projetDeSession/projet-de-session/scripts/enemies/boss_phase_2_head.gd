class_name FinalBoss
extends CharacterBody2D

@onready var players = get_tree().get_nodes_in_group("players")
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var enrage : Timer = $Enrage
@onready var mechanicTimer : Timer = $MechanicTimer

@export var mechanicScenes : Array[PackedScene] = []
enum Mechanic {
	SPREAD,
	STACK
}
var currentMechanic : Mechanic = Mechanic.STACK

var playerEnmity = [0, 0, 0, 0]
var currentTarget
var startEnrage = false

var hp : int = 10000
var speed = 50.0
var damage = 100

func _ready() -> void:
	animationPlayer.play("Eating")

func is_enemy() -> bool:
	return true

func _physics_process(delta: float) -> void:
	if (hp < 0):
		self.queue_free()
		get_node("../WinScreen").win_screen()
	if enrage.time_left < 2 && !startEnrage:
		startEnrage = true
		$EnrageSprite.visible = true
	$ProgressBar.value = hp
		
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
				emnity *= 4
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

func _on_enrage_timeout() -> void:
	for player in players:
		player.handle_hurt(2000000)
	$EnrageSprite.visible = false
	GlobalSoundManager.play_big_fireball_impact_sfx()

func _on_auto_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("is_player") && body == currentTarget:
		body.handle_hurt(damage)

func _on_auto_attack_delay_timeout() -> void:
	$AutoAttackRange/CollisionShape2D.set_deferred("disabled", !$AutoAttackRange/CollisionShape2D.disabled)

func _on_mechanic_timer_timeout() -> void:
	match currentMechanic:
		Mechanic.SPREAD:
			for player in players:
				var spread = mechanicScenes[0].instantiate()
				player.add_child(spread)
			currentMechanic = Mechanic.STACK
			return
		Mechanic.STACK:
			var alive_players = []
			var stack = mechanicScenes[1].instantiate()
			
			for player in players:
				if player.is_dead() == false:
					alive_players.append(player)
			if alive_players.size() == 0:
				return
				
			var player = alive_players[randi() % alive_players.size()]
			player.add_child(stack)
			currentMechanic = Mechanic.SPREAD
			return
