extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
var stanceOn: bool = false

func _ready() -> void:
	player.playerClass = "Knight"
	player.highlight_type = "HighlightKnight"
	player.speed = 300.0
	player.hp = 200
	player.max_hp = 400
	player.controlled_by = "P2"

func _physics_process(_delta: float) -> void:
	if player.is_dead():
		return
	player.get_movement_input()
	if GCD.time_left > 0:
		return
		
	if Input.is_action_just_pressed("P2_Ability_1"):
		GCD.wait_time = 5
		GCD.start()
		
func ability_1():
	pass
	
func ability_2():
	pass

func ability_3():
	pass

func ability_4():
	pass
