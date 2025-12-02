extends Area2D

@onready var slashDuration : Timer = $SlashDuration
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
var damage = 100
var caster : String = ""

func _ready() -> void:
	slashDuration.start()
	animationPlayer.play("slash")

func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_enemy")):
		body.handle_emnity(caster, damage)
		body.hp -= damage
		GlobalSoundManager.play_metal_impact_sfx()

func _on_slash_duration_timeout() -> void:
	self.queue_free()
