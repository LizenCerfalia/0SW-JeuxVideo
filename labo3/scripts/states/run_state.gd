extends BaseState
class_name PlayerRun

@export var player : Player
var animationTree : AnimationTree

const SPEED = 300.0

func manage_input() -> float:	
	var dir : float = Input.get_axis("Left","Right")
	if (Input.is_action_just_pressed("Jump")):
		Transitioned.emit(self, "jump")	
	if (Input.is_action_just_pressed("Attack")):
		Transitioned.emit(self, "attack")
	
	
	return dir

func update(delta : float) -> void:
	if not animationTree :
		animationTree = player.get_animation_tree()

	var dir := manage_input()
	
	if dir != 0.0 :
		player.velocity.x = dir * SPEED
	else :
		player.velocity.x = dir
	
	if (player.velocity.length() == 0) :
		Transitioned.emit(self, "idle")
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
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
