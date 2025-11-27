class_name AIHeal
extends BaseState

var player
var animationTree : AnimationTree
var hurtPlayers = []
var targets = []

func handle_inputs(input_event: InputEvent) -> void:
	pass
	
func update(delta: float) -> void:
	targets = player.potential_targets
	if (targets.size() == 0 && hurtPlayers.size() == 0 && player.is_dead()):
		return
		
	var most_hurt_player
	var damage_received = 100
	for hurtPlayer in hurtPlayers:
		if hurtPlayer.hp * 100 / hurtPlayer.max_hp < damage_received :
			damage_received = hurtPlayer.hp * 100 / hurtPlayer.max_hp
			most_hurt_player = hurtPlayer
	
	if most_hurt_player == null:
		Transitioned.emit(self, "AttackState")
		return
	var direction_to_player = player.global_position.direction_to(most_hurt_player.global_position)
	
	player.velocity = direction_to_player * player.speed
	
	player.animationTree.set("parameters/Walk/blend_position", direction_to_player)
	player.animationTree.set("parameters/Idle/blend_position", direction_to_player)
	
	if (player.global_position.distance_to(most_hurt_player.global_position) < 250):
		if most_hurt_player.is_dead():
			player.get_parent().ability_4()
		else:
			player.get_parent().ability_3()
	else:
		player.current_target = targets[randi() % targets.size()] 
		player.get_parent().ability_1()
		
	if most_hurt_player.hp == most_hurt_player.max_hp:
		Transitioned.emit(self, "AttackState")
	
func physics_update(delta: float) -> void:
	pass
func enter() -> void:
	hurtPlayers = get_tree().get_nodes_in_group("players")
	hurtPlayers.erase(player)
	player.playback.travel("Walk")
	
func exit() -> void:
	pass
