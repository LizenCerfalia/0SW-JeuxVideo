extends Area2D

var damage : int = 20
var speed : float = 500.0

func _physics_process(delta: float) -> void:
	pass
	


func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_enemy")):
		body.hp -= damage
	self.queue_free()
