extends Node2D

@onready var player: GenericPlayer = $GenericPlayer
@onready var GCD: Timer = $GCD
@onready var fireballDirection: = $GenericPlayer/FireballDirection
@export var ability_1_scene : PackedScene
@export var ability_2_scene : PackedScene
@export var ability_3_scene : PackedScene
@export var ability_4_scene : PackedScene

func _ready() -> void:
	player.playerClass = "Sorcerer"
	player.highlight_type = "HighlightSorcerer"
	player.speed = 200.0
	player.hp = 100
	player.max_hp = 200
	player.controlled_by = "AI"

func _physics_process(_delta: float) -> void:
	if player.is_dead():
		return
	player.get_movement_input()

func ability_1():
	if (player.current_target == null):
		return
	fireballDirection.look_at(player.current_target.global_position)
	var fireball = ability_1_scene.instantiate()
	add_child(fireball)
	fireball.global_transform = fireballDirection.global_transform
	fireball.caster = "Sorcerer"
	fireball.scale = Vector2(2.0, 2.0)
	
func ability_2():
	if (player.current_target == null):
		return
	fireballDirection.look_at(player.current_target.global_position)
	var fireball = ability_2_scene.instantiate()
	add_child(fireball)
	fireball.global_transform = fireballDirection.global_transform
	fireball.caster = "Sorcerer"
	fireball.scale = Vector2(10.0, 10.0)

func ability_3():
	pass

func ability_4():
	pass
