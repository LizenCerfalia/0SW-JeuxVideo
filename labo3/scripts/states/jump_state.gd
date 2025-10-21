extends BaseState
class_name PlayerJump

@export var player : Player
var animationTree : AnimationTree

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func manage_input() -> float:	
	var dir : float = Input.get_axis("Left","Right")
	
	return dir

func enter():
	animationTree = player.get_animation_tree()
	player.velocity.y = JUMP_VELOCITY	
	
func update(delta: float) -> void:
	if not animationTree :
		animationTree = player.get_animation_tree()
		
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		Transitioned.emit(self, "run")

	var dir := manage_input()
	
	if dir != 0.0 :
		player.velocity.x = dir * SPEED
	else :
		player.velocity.x = dir
	
	player.direction = dir
	
func physics_update(delta: float) -> void:
	if not animationTree : return
		
	if (player.velocity.length() > 0):
		animationTree["parameters/conditions/is_idle"] = false
		animationTree["parameters/conditions/is_moving"] = true
		animationTree["parameters/conditions/is_attacking"] = false
		
		if(player.velocity > Vector2.ZERO):
			animationTree["parameters/Attack/blend_position"] = 1
			animationTree["parameters/Idle/blend_position"] = 1
			animationTree["parameters/Run/blend_position"] = 1
		if(player.velocity < Vector2.ZERO):
			animationTree["parameters/Attack/blend_position"] = -1
			animationTree["parameters/Idle/blend_position"] = -1
			animationTree["parameters/Run/blend_position"] = -1
