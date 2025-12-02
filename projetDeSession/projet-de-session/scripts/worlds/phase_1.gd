extends Node2D

@onready var gui = $GUI

@onready var templarHotbar = $GUI/TemplarAbilities
@onready var assassinHotbar = $GUI/AssassinAbilities
@onready var knightHotbar = $GUI/KnightAbilities
@onready var sorcererHotbar = $GUI/SorcererAbilities

@onready var templarGCD = $Templar/GCD
@onready var assassinGCD = $Assassin/GCD
@onready var knightGCD = $Knight/GCD
@onready var sorcererGCD = $Sorcerer/GCD

@onready var NerdDataRAM = $NerdDataRAM
@onready var NerdDataFPS = $NerdDataFPS

func _ready() -> void:
	gui.size = get_viewport_rect().size / 1.5
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("Pause"):
		$PauseScreen.pause_the_game()
	if Input.is_action_just_pressed("NerdData"):
		NerdDataFPS.visible = !NerdDataFPS.visible
		NerdDataRAM.visible = !NerdDataRAM.visible
		NerdDataFPS.text = "FPS: " + str(Engine.get_frames_per_second())
		NerdDataRAM.text = "RAM: " + str(Performance.get_monitor(Performance.MEMORY_STATIC))
		
	
	if templarGCD.time_left > 0:
		var ability
		var nodeName
		for i in range(1,5):
			
			nodeName = "HBoxContainer/Ability" + str(i) + "/ProgressBar"
			ability = templarHotbar.get_node(nodeName)
			ability.max_value = templarGCD.wait_time
			ability.value = templarGCD.time_left
			
	if assassinGCD.time_left > 0:
		var ability
		var nodeName
		for i in range(1,5):
			
			nodeName = "HBoxContainer/Ability" + str(i) + "/ProgressBar"
			ability = assassinHotbar.get_node(nodeName)
			ability.max_value = assassinGCD.wait_time
			ability.value = assassinGCD.time_left
			
	if knightGCD.time_left > 0:
		var ability
		var nodeName
		for i in range(1,5):
			
			nodeName = "HBoxContainer/Ability" + str(i) + "/ProgressBar"
			ability = knightHotbar.get_node(nodeName)
			ability.max_value = knightGCD.wait_time
			ability.value = knightGCD.time_left
			
	if sorcererGCD.time_left > 0:
		var ability
		var nodeName
		for i in range(1,5):
			
			nodeName = "HBoxContainer/Ability" + str(i) + "/ProgressBar"
			ability = sorcererHotbar.get_node(nodeName)
			ability.max_value = sorcererGCD.wait_time
			ability.value = sorcererGCD.time_left
