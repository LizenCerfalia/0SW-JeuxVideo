extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
var stanceOn: bool = false
var controlled_by = "P2"

func _ready() -> void:
	player.playerClass = "Knight"
	player.highlight_type = "HighlightKnight"
	player.speed = 300.0
	player.hp = 200
	player.max_hp = 400
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
	GCD.wait_time = 5
	GCD.start()
		
	var potential_targets = player.potential_targets
	for target in potential_targets:
		target.handle_emnity("Knight", 5000)

func ability_4():
	if GCD.time_left > 0:
		return	
	GCD.wait_time = 0.5
	GCD.start()
	
	stanceOn = !stanceOn
