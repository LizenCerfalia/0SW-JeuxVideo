extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
var stanceOn: bool = false

func _ready() -> void:
	player.playerClass = "Knight"
	player.highlight_type = "HighlightKnight"
	player.speed = 300.0
	player.hp = 200
	player.controlled_by = "P2"

func _physics_process(_delta: float) -> void:
	player.get_movement_input()
	if GCD.time_left > 0:
		return
		
		
	if Input.is_action_just_pressed("P2_Ability_1"):
		GCD.wait_time = 5
		GCD.start()
