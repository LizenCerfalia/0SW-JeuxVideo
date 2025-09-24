extends Node2D
class_name Projectile

var speed : int = 750

func _physics_process(delta: float) -> void:
	position -= transform.y * speed * delta
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	# On utilise mobs, mais cela peut être n'importe quel groupe
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
