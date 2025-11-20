class_name GenericPlayer
extends CharacterBody2D

var dead : bool = false	

func is_player() -> bool:
	return true
	
func is_dead() -> bool:
	return dead

var current_time
var previous_time = 0
var current_direction = 1

#tab targeting
var potential_targets = []
var current_target = null
var current_target_index = -1

var playerClass: String = ""
var highlight_type: String = ""
var speed: float
var hp: int
var max_hp: int
var controlled_by: String
@onready var sprite: Sprite2D = $Sprite2D
@onready var animationTree: AnimationTree = $AnimationTree
@onready var playback = animationTree.get("parameters/playback")
@onready var GUI = get_node("/root/Phase1/GUI")

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
		if (Input.is_action_just_pressed("P1_Target_Enemy")):
			handle_tab_targeting()
	else:
		dir = Input.get_vector("P2_Left", "P2_Right","P2_Up","P2_Down").normalized()
		if (Input.is_action_just_pressed("P2_Target_Enemy")):
			handle_tab_targeting()
		
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
	handle_tab_targeting()
		
	previous_time = current_time

func handle_tab_targeting():
	if potential_targets.size() > 0:
		current_target_index += 1
		
		if current_target_index >= potential_targets.size():
			current_target_index = 0
		
		var new_target = potential_targets[current_target_index]
		if new_target:
			if current_target and current_target.has_node(highlight_type):
				current_target.get_node(highlight_type).visible = false

			current_target = new_target

			if current_target.has_node(highlight_type):
				current_target.get_node(highlight_type).visible = true

func _on_target_zone_body_entered(body: Node2D) -> void:
	if body.has_method("is_enemy") and body.is_enemy():
		potential_targets.append(body)

func _on_target_zone_body_exited(body: Node2D) -> void:
	if body in potential_targets:
		potential_targets.erase(body)
		
func handle_hurt(value: int):
	hp -= value
	if hp > max_hp:
		hp = max_hp
	if hp <= 0 && !is_dead():
		dead = true
		sprite.rotate(90)
		for target in potential_targets:
			target.lose_emnity(playerClass)
		
	GUI.hp_update(playerClass, hp)
	
func get_ressed():
	if is_dead():
		return
	
	sprite.rotate(-90)
	dead = false
