extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
@onready var HealDelay: Timer = $HealDuration
@onready var ResDelay: Timer = $ResDelay
@onready var fireballDirection: = $GenericPlayer/FireballDirection
@export var ability_1_scene : PackedScene
var potential_heal_targets = []

func _ready() -> void:
	player.playerClass = "Templar"
	player.highlight_type = "HighlightTemplar"
	player.speed = 250.0
	player.hp = 100
	player.max_hp = 200
	player.controlled_by = "P1"

func _physics_process(_delta: float) -> void:
	if player.is_dead():
		return
	
	player.get_movement_input()
	if player.controlled_by == "P1":
		if Input.is_action_just_pressed("P1_Ability_1"):
			ability_1()
		if Input.is_action_just_pressed("P1_Ability_2"):
			ability_2()
		if Input.is_action_just_pressed("P1_Ability_3"):
			ability_3()
		if Input.is_action_just_pressed("P1_Ability_4"):
			ability_4()
	if player.controlled_by == "P2":
		if Input.is_action_just_pressed("P2_Ability_1"):
			ability_1()
		if Input.is_action_just_pressed("P2_Ability_2"):
			ability_2()
		if Input.is_action_just_pressed("P2_Ability_3"):
			ability_3()
		if Input.is_action_just_pressed("P2_Ability_4"):
			ability_4()

func ability_1():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 1
	GCD.start()
	if (player.current_target == null):
		return
	fireballDirection.look_at(player.current_target.global_position)
	var fireball = ability_1_scene.instantiate()
	add_child(fireball)
	fireball.global_transform = fireballDirection.global_transform
	fireball.caster = "Templar"
	fireball.scale = Vector2(2.0, 2.0)
	
func ability_2():	
	if GCD.time_left > 0:
		return
	GCD.wait_time = 3
	GCD.start()
	player.global_position += player.velocity + player.velocity / 3
	
func ability_3():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 3
	GCD.start()
	HealDelay.start()
	$GenericPlayer/HealRange/Sprite2D.visible = true
	

func ability_4():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 8
	GCD.start()
	ResDelay.start()
	$GenericPlayer/HealRange/Sprite2D.visible = true


func _on_heal_range_body_entered(body: Node2D) -> void:
	if (body.has_method("is_player")):
		potential_heal_targets.append(body)

func _on_heal_range_body_exited(body: Node2D) -> void:
	if (body.has_method("is_player")):
		potential_heal_targets.erase(body)

func _on_heal_delay_timeout() -> void:
	$GenericPlayer/HealRange/Sprite2D.visible = false
	
	for target in potential_heal_targets:
		target.handle_hurt(-50)

func _on_res_delay_timeout() -> void:
	$GenericPlayer/HealRange/Sprite2D.visible = false
	
	for target in potential_heal_targets:
		if target.is_dead():
			target.get_ressed()
