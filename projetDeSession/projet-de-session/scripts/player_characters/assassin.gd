extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
@onready var dashDuration: Timer = $DashDuration
@onready var slashDirection: Marker2D = $GenericPlayer/SlashDirection

var controlled_by = "AI"
@export var ability_1_scene : PackedScene
@export var ability_2_scene : PackedScene

func _ready() -> void:
	player.playerClass = "Assassin"
	player.highlight_type = "HighlightAssassin"
	player.speed = 250.0
	player.hp = 100
	player.max_hp = 100
	player.controlled_by = controlled_by

func _physics_process(delta: float) -> void:
	if player.is_dead():
		return
	player.get_movement_input(delta)
	
	if controlled_by == "P1":
		if Input.is_action_just_pressed("P1_Ability_1"):
			ability_1()
		if Input.is_action_just_pressed("P1_Ability_2"):
			ability_2()
		if Input.is_action_just_pressed("P1_Ability_3"):
			ability_3()
		if Input.is_action_just_pressed("P1_Ability_4"):
			ability_4()
	if controlled_by == "P2":
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
	if (player.current_target == null):
		return
	GCD.wait_time = 3
	GCD.start()
	slashDirection.look_at(player.current_target.global_position)
	var slash = ability_1_scene.instantiate()
	add_child(slash)
	slash.global_transform = slashDirection.global_transform
	slash.caster = "Assassin"
	slash.scale = Vector2(2.0, 1.0)
	
func ability_2():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 1
	GCD.start()
	var slash = ability_2_scene.instantiate()
	player.add_child(slash)
	slash.caster = "Assassin"
	slash.scale = Vector2(4.0, 4.0)

func ability_3():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 1
	GCD.start()
	player.speed = 500
	dashDuration.start()

func ability_4():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 3
	GCD.start()
	player.global_position += player.velocity + player.velocity / 3

func _on_dash_duration_timeout() -> void:
	player.speed = 250
