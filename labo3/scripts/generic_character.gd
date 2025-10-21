extends CharacterBody2D
class_name GenericCharacter

var animationTree : AnimationTree
var sprite : Sprite2D
var direction : float

func get_animation_tree () -> AnimationTree:
	return animationTree
