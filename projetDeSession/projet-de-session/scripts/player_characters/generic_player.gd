class_name GenericPlayer
extends CharacterBody2D

var current_time
var previous_time = 0
var current_direction = 1

signal PlayerHit(playerClass: String, value : int)

var playerClass: String = ""
var speed: float
var hp: int
var controlled_by: String
@onready var sprite: Sprite2D = $Sprite2D
@onready var animationTree: AnimationTree = $AnimationTree
@onready var playback = animationTree.get("parameters/playback")

func get_movement_input():
	match controlled_by:
		"P1":
			player_controls()
		"P2":
			player_controls()
		"AI":
			ai_controls()
		_:
			pass
	
func player_controls():
	var dir
	if (controlled_by == "P1"):
		dir = Input.get_vector("P1_Left", "P1_Right","P1_Up","P1_Down").normalized()
	else:
		dir = Input.get_vector("P2_Left", "P2_Right","P2_Up","P2_Down").normalized()
		
	if (dir != Vector2.ZERO):
		playback.travel("Walk")
		animationTree.set("parameters/Walk/blend_position", dir)
		animationTree.set("parameters/Idle/blend_position", dir)
	else:
		playback.travel("Idle")
	
	velocity = dir * speed
	move_and_slide()
	
func ai_controls():
	current_time = Time.get_ticks_msec()
	
	if (current_direction != 0):
		playback.travel("Walk")
		var vector = Vector2(current_direction, 0)
		animationTree.set("parameters/Walk/blend_position", vector)
	else:
		playback.travel("Idle")
	
	velocity.x = current_direction * speed
	move_and_slide()
	
	
	if ((current_time - previous_time) < 1000):
		return
		
	current_direction = -current_direction
		
	previous_time = current_time
