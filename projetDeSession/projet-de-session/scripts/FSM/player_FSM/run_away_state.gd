class_name AIRunAway
extends BaseState

var player
var animationTree : AnimationTree
var targets = []

func handle_inputs(input_event: InputEvent) -> void:
	pass
	
func update(delta: float) -> void:
	targets = player.potential_targets
	if (targets.size() == 0 || player.is_dead()):
		return
		
	var closest_target
	var closest_distance = 10000000
	for target in targets:
		var distance = player.global_position.distance_to(target.global_position)
		if  distance < closest_distance:
			closest_distance = distance
			closest_target = target
			
	if closest_distance < 400:
		Transitioned.emit(self, "AttackState")
			
	player.current_target = closest_target
	var direction_to_target = player.global_position.direction_to(closest_target.global_position)
	player.velocity = -direction_to_target * player.speed
	
	player.animationTree.set("parameters/Walk/blend_position", -direction_to_target)
	player.animationTree.set("parameters/Idle/blend_position", -direction_to_target)
	
	player.get_parent().ability_1()
	
	
func physics_update(delta: float) -> void:
	pass
	
func enter() -> void:
	player.playback.travel("Walk")
	
func exit() -> void:
	pass
