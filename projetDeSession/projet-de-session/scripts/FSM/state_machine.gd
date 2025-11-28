extends Node

@export var initial_state : BaseState
@export var player : CharacterBody2D
var current_state : BaseState
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().controlled_by != "AI":
		self.queue_free()
	# Pour ajouter les états, il suffit de les ajouter comme enfants de la machine à état
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			child.player = player
	
	if initial_state :
		initial_state.enter()
		current_state = initial_state
	
func _process(delta: float) -> void:
	if player.is_dead():
		return
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if player.is_dead():
		return
	if current_state:
		current_state.physics_update(delta)

# Fonction pour changer d'état
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
