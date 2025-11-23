extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
var last_spawned_collisions: Array[CollisionShape2D] = []

@onready var collisionTimer = $CollisionDelay

func _ready() -> void:
	_on_spawn_rate_timeout()


func _on_spawn_rate_timeout() -> void:
	if enemy_scenes.is_empty():
		print("ERROR: enemy_scenes array is empty in the Inspector!")
		return # Stop execution if no scenes are assigned
	
	last_spawned_collisions.clear()
	
	for i in 4:
		var random_enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
		var enemy_instance = random_enemy_scene.instantiate()
		var viewport_width = get_viewport_rect().size.x
		var random_x = randf_range(0, viewport_width)
		var viewport_height = get_viewport_rect().size.y
		var random_y = randf_range(0, viewport_height)
		
		enemy_instance.global_position = Vector2(random_x, random_y)
		var collision = enemy_instance.get_node("GenericEnemy/CollisionShape2D")
		collision.disabled = true
		get_parent().add_child.call_deferred(enemy_instance)
		last_spawned_collisions.append(collision)
	collisionTimer.start()


func _on_collision_delay_timeout() -> void:
	for collision in last_spawned_collisions:
		collision.disabled = false
