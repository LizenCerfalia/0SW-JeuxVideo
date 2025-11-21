extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
var controlled_by = "AI"
@onready var GCD: Timer = $GCD
@onready var dashDuration: Timer = $DashDuration

func _ready() -> void:
	player.playerClass = "Assassin"
	player.highlight_type = "HighlightAssassin"
	player.speed = 350.0
	player.hp = 100
	player.max_hp = 200
	player.controlled_by = controlled_by

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
	
func ability_2():
	if GCD.time_left > 0:
		return

func ability_3():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 1
	GCD.start()
	player.speed = 700
	dashDuration.start()

func ability_4():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 3
	GCD.start()
	player.global_position += player.velocity + player.velocity / 3
