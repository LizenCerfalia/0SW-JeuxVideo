extends Area2D

var damage : int = 2000000
var speed : float = 500.0
var caster : String = ""

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_enemy")):
		body.handle_emnity(caster, damage)
	self.queue_free()
