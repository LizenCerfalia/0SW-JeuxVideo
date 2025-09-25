extends CharacterBody2D
class_name Player

var screen_size

@export var speed : int = 400
@export var acceleration : float = 10.0
@export var friction : float = 10.0
@export var projectile_scene : PackedScene

func _ready() -> void:
	screen_size = get_viewport_rect().size

func get_input(_delta: float):
	
	var dir = Input.get_axis("left", "right")
	if (dir < 0):
		velocity.x = move_toward(velocity.x, -speed, acceleration)
		position.x = clamp(position.x, 0, screen_size.x)
	elif (dir > 0):
		velocity.x = move_toward(velocity.x, speed, acceleration)
		position.x = clamp(position.x, 0, screen_size.x)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		position.x = clamp(position.x, 0, screen_size.x)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide()

func shoot():
	var p = projectile_scene.instantiate()
	get_parent().add_child(p)
	p.global_transform = $Muzzle.global_transform
