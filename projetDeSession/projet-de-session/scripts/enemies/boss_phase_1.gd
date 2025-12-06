extends CharacterBody2D

const SAVE_FILE_DIR = "user://save/"
const SAVE_FILE_NAME = "save_data.tres"
const SAVE_FILE_PATH = SAVE_FILE_DIR + SAVE_FILE_NAME

@onready var players = get_tree().get_nodes_in_group("players")
@onready var animationTree : AnimationTree = $AnimationTree
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

var hp : int = 4500
const SPEED = 100.0
var damage = 100

func save_game() -> void:
	var save_data_res: SaveData

	if ResourceLoader.exists(SAVE_FILE_PATH):
		var loaded_resource = ResourceLoader.load(SAVE_FILE_PATH)
		if loaded_resource is SaveData:
			save_data_res = loaded_resource.duplicate(true)
		else:
			save_data_res = SaveData.new()
	else:
		save_data_res = SaveData.new()

	save_data_res.current_phase = "phase_2"
	save_data_res.TemplarControls = WorldState.TemplarControls
	save_data_res.AssassinControls = WorldState.AssassinControls
	save_data_res.KnightControls = WorldState.KnightControls
	save_data_res.SorcererControls = WorldState.SorcererControls

	ResourceSaver.save(save_data_res, SAVE_FILE_PATH)

func is_enemy() -> bool:
	return true

func _physics_process(delta: float) -> void:
	if (hp < 0):
		handle_death()
	if enrage.time_left < 2 && !startEnrage:
		startEnrage = true
		$EnrageSprite.visible = true
	$ProgressBar.value = hp
		
	get_target()
	var direction = (currentTarget.global_position - global_position).normalized()
	velocity = direction * SPEED
	animationTree.set("parameters/Drive/blend_position", direction)
	
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
			
func handle_death():
	save_game()
	GlobalMusicManager.PlayPhase2Music()
	get_tree().change_scene_to_file.call_deferred("res://scenes/worlds/phase_2.tscn")

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
