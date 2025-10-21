extends BaseState
class_name PlayerAttack

@export var player : Player
var animationTree : AnimationTree
var dash_timer: Timer

const ATTACK_SPEED = 200.0
const ATTACK_DURATION = 0.4

func _ready() -> void:
	animationTree = player.get_animation_tree()
	dash_timer = Timer.new()
	add_child(dash_timer)
	dash_timer.wait_time = ATTACK_DURATION
	dash_timer.autostart = false
	dash_timer.one_shot = true
	dash_timer.timeout.connect(_on_dash_timer_timeout)

func manage_input() -> float:	
	var dir : float = Input.get_axis("Left","Right")
	
	return dir

func enter():
	dash_timer.start()
	
func update(delta: float) -> void:
	if not animationTree :
		animationTree = player.get_animation_tree()

	var dir := manage_input()
	

	if(animationTree["parameters/Attack/blend_position"] == 1):
		player.velocity.x = ATTACK_SPEED
	else:
		player.velocity.x = -ATTACK_SPEED
			
	
	player.direction = dir
		
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	
func physics_update(delta: float) -> void:
	if not animationTree : return
		
	if (player.velocity.length() > 0):
		animationTree["parameters/conditions/is_idle"] = false
		animationTree["parameters/conditions/is_moving"] = false
		animationTree["parameters/conditions/is_attacking"] = true
		
		if(player.velocity > Vector2.ZERO):
			animationTree["parameters/Attack/blend_position"] = 1
			animationTree["parameters/Idle/blend_position"] = 1
			animationTree["parameters/Run/blend_position"] = 1
		if(player.velocity < Vector2.ZERO):
			animationTree["parameters/Attack/blend_position"] = -1
			animationTree["parameters/Idle/blend_position"] = -1
			animationTree["parameters/Run/blend_position"] = -1

func _on_dash_timer_timeout():
	Transitioned.emit(self, "idle")
	player.velocity.x = 0.0
