extends Node2D

@onready var enemy : GenericEnemy = $GenericEnemy
@onready var explosionSprite : Sprite2D = $GenericEnemy/Explosion/Sprite2D
@onready var explosionDelay : Timer = $ExplosionDelay
var targetsInRange = []

func _ready() -> void:
	enemy.hp = 100
	enemy.speed = 300.0
	enemy.damage = 200
	
func start_explosion():
	explosionDelay.start()
	explosionSprite.visible = true
	enemy.speed = 10

func _on_explosion_delay_timeout() -> void:
	for target in targetsInRange:
		if (target.has_method("is_player") && !target.is_dead()):
			target.handle_hurt(enemy.damage)
		if (target.has_method("is_enemy")):
			target.hp -= enemy.damage
	GlobalSoundManager.play_big_fireball_impact_sfx()
	self.queue_free()
	
func _on_explosion_body_entered(body: Node2D) -> void:
	if (body.has_method("is_enemy") || body.has_method("is_player")):
		targetsInRange.append(body)
		
func _on_explosion_body_exited(body: Node2D) -> void:
	if (body.has_method("is_enemy") || body.has_method("is_player")):
		targetsInRange.erase(body)

func _on_automatic_explosion_range_body_entered(body: Node2D) -> void:
	if (body.has_method("is_player")):
		start_explosion()
	print("allo")
