extends CharacterBody2D

@export var speed = 400.0

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("P1_Left", "P1_Right","P1_Up","P1_Down").normalized()
	
	velocity = dir * speed
	move_and_slide()
	
