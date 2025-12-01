extends Control

const SAVE_FILE_DIR = "user://save/"
const SAVE_FILE_NAME = "save_data.tres"
const SAVE_FILE_PATH = SAVE_FILE_DIR + SAVE_FILE_NAME

func _ready() -> void:
	var dir = DirAccess.open("user://")
	if dir and not dir.dir_exists(SAVE_FILE_DIR):
		dir.make_dir(SAVE_FILE_DIR)

func save_game() -> void:
	var save_data_res: SaveData

	if ResourceLoader.exists(SAVE_FILE_PATH):
		var loaded_resource = ResourceLoader.load(SAVE_FILE_PATH)
		if loaded_resource is SaveData:
			save_data_res = loaded_resource.duplicate(true)
		else:
			save_data_res = SaveData.new()
	else:
		save_data_res = SaveData.new()

	save_data_res.current_phase = "phase_1"
	save_data_res.TemplarControls = WorldState.TemplarControls
	save_data_res.AssassinControls = WorldState.AssassinControls
	save_data_res.KnightControls = WorldState.KnightControls
	save_data_res.SorcererControls = WorldState.SorcererControls

	ResourceSaver.save(save_data_res, SAVE_FILE_PATH)

const CHARACTERS := ["Templar", "Assassin", "Knight", "Sorcerer"]

func _get_button_node(char_name: String, player_id: String) -> Button:
	var node = get_node_or_null("%s%s" % [char_name, player_id])
	if node is Button:
		return node
	else:
		return null

func update_controls(char_name: String, player_id: String, toggled_on: bool) -> void:
	var state_prop: String = char_name + "Controls"

	if toggled_on:
		if WorldState.get(state_prop) != ("P1" if player_id == "P2" else "P2"):
			WorldState.set(state_prop, player_id)
			
		for other_char in CHARACTERS:
			var other_state_prop: String = other_char + "Controls"
			if other_char != char_name and WorldState.get(other_state_prop) != ("P1" if player_id == "P2" else "P2"):
				WorldState.set(other_state_prop, "AI")

		for chara in CHARACTERS:
			var button: Button = _get_button_node(chara, player_id)
			if button:
				button.flat = (chara != char_name)
	else:
		WorldState.set(state_prop, "AI")
		var button: Button = _get_button_node(char_name, player_id)
		if button:
			button.flat = true

func _on_templar_p_2_toggled(toggled_on: bool) -> void:
	update_controls("Templar", "P2", toggled_on)

func _on_assassin_p_2_toggled(toggled_on: bool) -> void:
	update_controls("Assassin", "P2", toggled_on)

func _on_knight_p_2_toggled(toggled_on: bool) -> void:
	update_controls("Knight", "P2", toggled_on)

func _on_sorcerer_p_2_toggled(toggled_on: bool) -> void:
	update_controls("Sorcerer", "P2", toggled_on)

func _on_templar_p_1_toggled(toggled_on: bool) -> void:
	update_controls("Templar", "P1", toggled_on)

func _on_assassin_p_1_toggled(toggled_on: bool) -> void:
	update_controls("Assassin", "P1", toggled_on)

func _on_knight_p_1_toggled(toggled_on: bool) -> void:
	update_controls("Knight", "P1", toggled_on)
	
func _on_sorcerer_p_1_toggled(toggled_on: bool) -> void:
	update_controls("Sorcerer", "P1", toggled_on)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_start_pressed() -> void:
	save_game()
	GlobalMusicManager.PlayPhase1Music()
	get_tree().change_scene_to_file("res://scenes/worlds/phase_1.tscn")
