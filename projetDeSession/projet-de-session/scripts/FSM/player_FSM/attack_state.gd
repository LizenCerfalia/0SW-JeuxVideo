class_name AIAttack
extends BaseState

var player
var animationTree : AnimationTree
var targets = []

func handle_inputs(input_event: InputEvent) -> void:
	pass
	
func update(delta: float) -> void:
	targets = player.potential_targets
	if (targets.size() == 0):
		return
		
	for target in targets:
		if player.global_position.distance_to(target.global_position) < 250:
			Transitioned.emit(self, "RunAwayState")
	
	player.velocity = Vector2.ZERO
	player.current_target = targets[randi() % targets.size()] 
	player.get_parent().ability_1()
	
	
func physics_update(delta: float) -> void:
	pass
	
func enter() -> void:
	targets = player.potential_targets
	
func exit() -> void:
	pass
