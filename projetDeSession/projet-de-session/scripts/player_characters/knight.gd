extends CharacterBody2D

@export var speed = 400.0
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("P2_Left", "P2_Right","P2_Up","P2_Down").normalized()
	
	if (dir.x < 0.0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	velocity = dir * speed
	move_and_slide()
	
