class_name GenericPlayer
extends CharacterBody2D

var current_time
var previous_time = 0
var current_direction = 1

var speed: float
var controlled_by: String
@onready var sprite: Sprite2D = $Sprite2D
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

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
		animationPlayer.play("Walk_Side")
	else:
		animationPlayer.stop()
	
	if (dir.x < 0.0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	velocity = dir * speed
	move_and_slide()
	
func ai_controls():
	current_time = Time.get_ticks_msec()
	
	if (current_direction != 0):
		animationPlayer.play("Walk_Side")
	else:
		animationPlayer.stop()
	
	if (current_direction < 0.0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	velocity.x = current_direction * speed
	move_and_slide()
	
	
	if ((current_time - previous_time) < 1000):
		return
		
	current_direction = -current_direction
		
	previous_time = current_time
