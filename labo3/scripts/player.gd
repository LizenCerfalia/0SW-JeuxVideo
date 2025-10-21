extends GenericCharacter
class_name Player

func _ready() -> void:
	animationTree = $AnimationTree
	sprite = $Sprite2D
	animationTree["parameters/conditions/is_idle"] = true


func _physics_process(delta: float) -> void:
	move_and_slide()
