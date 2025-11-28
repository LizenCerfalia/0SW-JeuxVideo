extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
@onready var slashDirection: Marker2D = $GenericPlayer/SlashDirection
var stanceOn: bool = false
var controlled_by = "P1"

func stance_on():
	return stanceOn

@export var ability_1_scene : PackedScene
@export var ability_2_scene : PackedScene

func _ready() -> void:
	player.playerClass = "Knight"
	player.highlight_type = "HighlightKnight"
	player.speed = 200.0
	player.hp = 300
	player.max_hp = 300
	player.controlled_by = controlled_by
	ability_4()
	

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
		return
	if controlled_by == "P2":
		if Input.is_action_just_pressed("P2_Ability_1"):
			ability_1()
		if Input.is_action_just_pressed("P2_Ability_2"):
			ability_2()
		if Input.is_action_just_pressed("P2_Ability_3"):
			ability_3()
		if Input.is_action_just_pressed("P2_Ability_4"):
			ability_4()
		return
		
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
	slash.caster = "Knight"
	slash.scale = Vector2(2.0, 1.0)
	if stanceOn:
		slash.damage /= 2
	
func ability_2():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 1
	GCD.start()
	var slash = ability_2_scene.instantiate()
	player.add_child(slash)
	slash.caster = "Knight"
	slash.scale = Vector2(4.0, 4.0)
	if stanceOn:
		slash.damage /= 2

func ability_3():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 3
	GCD.start()
		
	var potential_targets = player.potential_targets
	for target in potential_targets:
		target.handle_emnity("Knight", 10000)

func ability_4():
	if GCD.time_left > 0:
		return
	GCD.wait_time = 0.5
	GCD.start()
	
	if stanceOn:
		stanceOn = false
		$GenericPlayer/StanceIndicator.visible = false
	else:
		stanceOn = true
		$GenericPlayer/StanceIndicator.visible = true
