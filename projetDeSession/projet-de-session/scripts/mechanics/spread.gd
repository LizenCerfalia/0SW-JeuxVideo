extends Area2D

var damage = 50

var potential_targets = []

func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_player")):
		potential_targets.append(body)

func _on_body_exited(body: Node2D) -> void:
	if (body.has_method("is_player")):
		potential_targets.erase(body)

func _on_spread_delay_timeout() -> void:
	for target in potential_targets:
		if target.is_dead() == false:
			target.handle_hurt(damage)
	self.queue_free()
