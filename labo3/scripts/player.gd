extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation_tree : AnimationTree = $AnimationTree

var direction : float = 0.0

func _ready() -> void:
	animation_tree.active = true
	
func _process(delta: float) -> void:
	update_animation_parameters()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("Killbind"):
		get_tree().reload_current_scene()
		
	direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_animation_parameters():
	animation_tree.set("parameters/conditions/is_idle", velocity == Vector2.ZERO)
	animation_tree.set("parameters/conditions/is_moving", velocity != Vector2.ZERO)
	animation_tree.set("parameters/conditions/is_attacking", Input.is_action_just_pressed("Attack"))
	
	if(direction != 0.0):
		animation_tree["parameters/Attack/blend_position"] = direction
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
