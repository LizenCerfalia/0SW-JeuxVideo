extends Control

const SAVE_FILE_DIR = "user://save/"
const SAVE_FILE_NAME = "save_data.tres"
const SAVE_FILE_PATH = SAVE_FILE_DIR + SAVE_FILE_NAME

const PHASE_1_IMAGE_PATH = "res://assets/world_assets/ground.png"
const PHASE_2_IMAGE_PATH = "res://assets/world_assets/hell_texture.png"

var save_data = SaveData.new()

func _ready() -> void:
	if ResourceLoader.exists(SAVE_FILE_PATH):

		var loaded_resource = ResourceLoader.load(SAVE_FILE_PATH)
		if loaded_resource is SaveData:
			save_data = loaded_resource.duplicate(true)
			
	update_ui()

func update_ui() -> void:
	var p1
	var p2
	
	if save_data.TemplarControls == "P1": p1 = "Templar"
	if save_data.AssassinControls == "P1": p1 = "Assassin"
	if save_data.KnightControls == "P1": p1 = "Knight"
	if save_data.SorcererControls == "P1": p1 = "Sorcerer"
		
	if save_data.TemplarControls == "P2": p2 = "Templar"
	if save_data.AssassinControls == "P2": p2 = "Assassin"
	if save_data.KnightControls == "P2": p2 = "Knight"
	if save_data.SorcererControls == "P2": p2 = "Sorcerer"
		
	if p1 != null:
		$P1.text = "Player 1: " + p1
	if p2 != null:
		$P2.text = "Player 2: " + p2
	
	match save_data.current_phase:
		"phase_1":
			$CurrentPhase.text = "Phase 1"
			$SaveSprite.texture = ResourceLoader.load(PHASE_1_IMAGE_PATH)
		"phase_2":
			$CurrentPhase.text = "Phase 2"
			$SaveSprite.texture = ResourceLoader.load(PHASE_2_IMAGE_PATH)
		_:
			pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/character_select.tscn")
	
func _on_load_pressed() -> void:
	if save_data.current_phase != null:
		WorldState.TemplarControls = save_data.TemplarControls
		WorldState.AssassinControls = save_data.AssassinControls
		WorldState.KnightControls = save_data.KnightControls
		WorldState.SorcererControls = save_data.SorcererControls
		
		var target_scene_path = "res://scenes/worlds/" + save_data.current_phase + ".tscn"
		get_tree().change_scene_to_file(target_scene_path)
