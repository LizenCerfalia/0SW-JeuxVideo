extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
@onready var fireballDirection: = $GenericPlayer/FireballDirection
@export var ability_1_scene : PackedScene
@export var ability_2_scene : PackedScene
@export var ability_3_scene : PackedScene
@export var ability_4_scene : PackedScene

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
		GCD.wait_time = 1
		GCD.start()
		ability_1()

func ability_1():
	if (player.current_target == null):
		return
	fireballDirection.look_at(player.current_target.global_position)
	var fireball = ability_1_scene.instantiate()
	add_child(fireball)
	fireball.global_transform = fireballDirection.global_transform
	fireball.caster = "Templar"
	fireball.scale = Vector2(2.0, 2.0)
	
func ability_2():
	pass

func ability_3():
	pass

func ability_4():
	pass
