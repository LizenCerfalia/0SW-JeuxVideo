extends CharacterBody2D

@export var speed = 250.0
@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("P1_Left", "P1_Right","P1_Up","P1_Down").normalized()
	
	if (dir != Vector2.ZERO):
		animationPlayer.play("Walk_Side")
	else:
		animationPlayer.stop()
	
	if (dir.x < 0.0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	velocity = dir * speed
	move_and_slide()
	
