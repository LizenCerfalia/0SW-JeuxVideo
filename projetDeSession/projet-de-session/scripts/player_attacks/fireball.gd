extends Area2D

var damage : int = 20
var speed : float = 500.0
var caster : String = ""

func _physics_process(_delta: float) -> void:
	pass
	


func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_enemy")):
		body.handle_aggro(caster, damage)
	self.queue_free()
