extends Area2D

@onready var slashDuration : Timer = $SlashDuration
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
var damage = 50
var speed = 200
var caster : String = ""

func _ready() -> void:
	slashDuration.start()
	animationPlayer.play("slash")
	
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_enemy")):
		body.handle_emnity(caster, damage)
		body.hp -= damage

func _on_slash_duration_timeout() -> void:
	self.queue_free()
