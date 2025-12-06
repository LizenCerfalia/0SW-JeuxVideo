extends Area2D

var damage : int = 350
var speed : float = 300.0
var caster : String = ""

func _ready() -> void:
	position += transform.x * 2

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("is_enemy")):
		body.handle_emnity(caster, damage)
		body.hp -= damage
		GlobalSoundManager.play_big_fireball_impact_sfx()
	self.queue_free()
