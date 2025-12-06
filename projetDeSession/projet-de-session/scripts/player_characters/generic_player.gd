class_name GenericPlayer
extends CharacterBody2D

var dead : bool

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
@onready var GUI = get_parent().get_parent().get_node("GUI")

var player_devices = {
	"P1": 0, # Device 0
	"P2": 1  # Device 1
}


func get_movement_input(delta: float):
	match controlled_by:
		"P1":
			player_controls(delta)
		"P2":
			player_controls(delta)
		"AI":
			ai_controls(delta)
		_:
			pass
	
func player_controls(delta: float):
	var dir = Vector2.ZERO
	
	if (controlled_by == "P1" or controlled_by == "P2"):
		var prefix = controlled_by
		var device_id = player_devices[controlled_by]
		
	
		dir = Input.get_vector(
			"%s_Left" % prefix, 
			"%s_Right" % prefix,
			"%s_Up" % prefix,
			"%s_Down" % prefix
		).normalized()
		
		if (Input.is_action_just_pressed("%s_Target_Enemy" % prefix, device_id)):
			handle_tab_targeting()
		
	if (dir != Vector2.ZERO):
		playback.travel("Walk")
		animationTree.set("parameters/Walk/blend_position", dir)
		animationTree.set("parameters/Idle/blend_position", dir)
	else:
		playback.travel("Idle")
	
	velocity = dir * speed
	move_and_collide(velocity * delta)
	
func ai_controls(_delta: float):
	
	move_and_collide(velocity * _delta)

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
	if (playerClass == "Knight"):
		var player = get_parent()
		if player.stanceOn:
			value /= 2
	hp -= value
	if hp > max_hp:
		hp = max_hp
	if hp < 0:
		hp = 0
	if hp <= 0 && !dead:
		dead = true
		sprite.rotate(90)
		for target in potential_targets:
			target.lose_emnity(playerClass)
		
	GUI.hp_update(playerClass, hp)
	
func get_ressed():
	if !is_dead():
		return
	
	sprite.rotate(-90)
	dead = false
