extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD

func _ready() -> void:
	player.playerClass = "Templar"
	player.highlight_type = "HighlightTemplar"
	player.speed = 250.0
	player.hp = 100
	player.controlled_by = "P1"

func _physics_process(_delta: float) -> void:
	player.get_movement_input()
	if GCD.time_left > 0:
		return
	
	if Input.is_action_just_pressed("P1_Ability_1"):
		GCD.wait_time = 5
		GCD.start()
		
