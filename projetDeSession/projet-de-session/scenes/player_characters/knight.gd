extends CharacterBody2D

@export var speed = 400.0

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("P2_Left", "P2_Right","P2_Up","P2_Down").normalized()
	
	velocity = dir * speed
	move_and_slide()
	
