class_name AISpread
extends BaseState

var player
var animationTree : AnimationTree
var playersToAvoid = []
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
			
	var closest_player
	closest_distance = 10000000
	for playerToAvoid in playersToAvoid:
		var distance = player.global_position.distance_to(playerToAvoid.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_player = playerToAvoid
	
	player.current_target = closest_target
	var direction_to_player = player.global_position.direction_to(closest_player.global_position)
	player.velocity = -direction_to_player * player.speed
	
	player.animationTree.set("parameters/Walk/blend_position", -direction_to_player)
	player.animationTree.set("parameters/Idle/blend_position", -direction_to_player)
	
	player.get_parent().ability_1()
	
	if WorldState.mechanic == null:
		Transitioned.emit(self, "AttackState")
	
func physics_update(delta: float) -> void:
	pass
	
func enter() -> void:
	playersToAvoid = get_tree().get_nodes_in_group("players")
	playersToAvoid.erase(player)
	player.playback.travel("Walk")
	
func exit() -> void:
	pass
