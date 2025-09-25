extends Node2D
class_name Projectile

var speed : int = 750

func _physics_process(delta: float) -> void:
	position -= transform.y * speed * delta
	if is_out_of_screen():
		queue_free()

func _on_Projectile_body_entered(body):
	if body.is_in_group("mobs"):
		body.get_parent().queue_free()
	queue_free()

func is_out_of_screen() -> bool:
	var screen_rect = get_viewport_rect()
	return not screen_rect.has_point(position)
