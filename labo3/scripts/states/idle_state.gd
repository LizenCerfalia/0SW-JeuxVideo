extends BaseState
class_name PlayerIdle

@export var player : Player
var animationTree : AnimationTree

func manage_input() -> void:	
	var dir : float = Input.get_axis("Left","Right")
	
	if (dir != 0.0):
		Transitioned.emit(self, "run")
	if (Input.is_action_just_pressed("Jump")):
		Transitioned.emit(self, "jump")	
	if (Input.is_action_just_pressed("Attack")):
		Transitioned.emit(self, "attack")

func enter():
	animationTree = player.get_animation_tree()	
	
func update(_delta: float) -> void:
	if not animationTree :
		animationTree = player.get_animation_tree()
	manage_input()
	
func physics_update(delta: float) -> void:
	if not animationTree : return
	
	animationTree["parameters/conditions/is_idle"] = true
	animationTree["parameters/conditions/is_moving"] = false
	animationTree["parameters/conditions/is_attacking"] = false
