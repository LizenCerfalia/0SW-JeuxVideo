class_name AIStack
extends BaseState

var player
var animationTree : AnimationTree
var targets = []
var playerToStackWith

func handle_inputs(input_event: InputEvent) -> void:
	pass
func update(delta: float) -> void:
	targets = player.potential_targets
	if (targets.size() == 0 || player.is_dead()):
		return
	player.current_target = targets[randi() % targets.size()] 
	
	var direction_to_player = player.global_position.direction_to(playerToStackWith.global_position)
	player.velocity = direction_to_player * player.speed
	
	player.animationTree.set("parameters/Walk/blend_position", direction_to_player)
	player.animationTree.set("parameters/Idle/blend_position", direction_to_player)
	
	if player.playerClass == "Templar" && player.global_position.distance_to(playerToStackWith.global_position) < 200:
		player.get_parent().ability_3()
	else:
		player.get_parent().ability_1()
		
	if WorldState.mechanic == null:
		Transitioned.emit(self, "AttackState")
	
	
func physics_update(delta: float) -> void:
	pass
	
func enter() -> void:
	var playersThatMayHaveStack = get_tree().get_nodes_in_group("players")
	
	for playerThatMayHaveStack in playersThatMayHaveStack:
		if playerThatMayHaveStack.has_node("Stack"):
			playerToStackWith = playerThatMayHaveStack
	player.playback.travel("Walk")
	
func exit() -> void:
	pass
