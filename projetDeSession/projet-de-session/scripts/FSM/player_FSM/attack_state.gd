class_name AIAttack
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
		
	for target in targets:
		if player.global_position.distance_to(target.global_position) < 250:
			Transitioned.emit(self, "RunAwayState")
		if (player.playerClass == "Knight" || player.playerClass == "Assassin"):
			if player.global_position.distance_to(target.global_position) > 800:
				Transitioned.emit(self, "GetCloserState")
	
	if player.playerClass == "Templar":
		var players = get_tree().get_nodes_in_group("players")
		for p in players:
			if p.hp <= p.max_hp / 2:
				Transitioned.emit(self, "HealState")

	
	if WorldState.mechanic == "Spread":
		Transitioned.emit(self, "SpreadState")
	elif WorldState.mechanic == "Stack":
		Transitioned.emit(self, "StackState")
	
	player.velocity = Vector2.ZERO
	player.current_target = targets[randi() % targets.size()] 
	player.get_parent().ability_1()
	
func physics_update(delta: float) -> void:
	pass
	
func enter() -> void:
	player.playback.travel("Idle")
	
func exit() -> void:
	pass
