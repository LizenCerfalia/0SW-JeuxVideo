extends Area2D

var damage = 200

var potential_targets = []

func _ready() -> void:
	WorldState.mechanic = "Stack"

func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_player")):
		potential_targets.append(body)

func _on_body_exited(body: Node2D) -> void:
	if (body.has_method("is_player")):
		potential_targets.erase(body)

func _on_stack_delay_timeout() -> void:
	
	var stacked_party_members = 0
	for target in potential_targets:
		if target.is_dead() == false:
			stacked_party_members += 1
	for target in potential_targets:
		if target.is_dead() == false:
			target.handle_hurt(damage / stacked_party_members)
	WorldState.mechanic = null
	print(stacked_party_members)
	self.queue_free()
