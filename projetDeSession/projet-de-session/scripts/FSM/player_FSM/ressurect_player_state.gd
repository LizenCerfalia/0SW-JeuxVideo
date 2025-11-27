class_name AIRessurect
extends BaseState

var player
var animationTree : AnimationTree
var hurtPlayers = []
var targets = []

func handle_inputs(input_event: InputEvent) -> void:
	pass
func update(delta: float) -> void:
	if hurtPlayers.size() == 0:
		return
		
	var dead_player
	for hurtPlayer in hurtPlayers:
		if hurtPlayer.is_dead():
			dead_player = hurtPlayer
	
	var direction_to_player = player.global_position.direction_to(dead_player.global_position)
	
	player.velocity = direction_to_player * player.speed
	
	player.animationTree.set("parameters/Walk/blend_position", direction_to_player)
	player.animationTree.set("parameters/Idle/blend_position", direction_to_player)
	
	if (player.global_position.distance_to(dead_player.global_position) < 150):
		player.get_parent().ability_4()
		
	if dead_player.is_dead() == false:
		Transitioned.emit(self, "AttackState")
	
func physics_update(delta: float) -> void:
	pass
	
func enter() -> void:
	hurtPlayers = get_tree().get_nodes_in_group("players")
	hurtPlayers.erase(player)
	player.playback.travel("Walk")
	
func exit() -> void:
	pass
