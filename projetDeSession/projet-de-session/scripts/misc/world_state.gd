extends Node

var mechanic = null
var TemplarControls = "AI"
var AssassinControls = "AI"
var KnightControls = "AI"
var SorcererControls = "AI"
var mute = false
var BGM = 0
var SFX = 0

func is_on_arcade() -> bool:
	return OS.get_executable_path().to_lower().contains("retropie")

func manage_end_game() -> void:
	if is_on_arcade() :
		if Input.is_action_pressed("hotkey") and Input.is_action_pressed("quit"):
			get_tree().quit()
	else :
		if Input.is_action_just_pressed("Ragequit"):
			get_tree().quit()

func _process(_delta: float) -> void:
	manage_end_game()
	if Input.is_action_just_pressed("Mute"):
		if mute:
			GlobalMusicManager.volume = 0
			GlobalSoundManager.volume = 0
			GlobalMusicManager.update_music_volume()
			GlobalSoundManager.update_sfx_volume()
		else:
			GlobalMusicManager.volume = BGM
			GlobalSoundManager.volume = SFX
			GlobalMusicManager.update_music_volume()
			GlobalSoundManager.update_sfx_volume()
		mute = !mute
	if Input.is_action_just_pressed("GoToPhase1"):
		GlobalMusicManager.Phase2Music.stop()
		GlobalMusicManager.PlayPhase1Music()
		get_tree().change_scene_to_file("res://scenes/worlds/phase_1.tscn")
	if Input.is_action_just_pressed("GoToPhase2"):
		GlobalMusicManager.Phase1Music.stop()
		GlobalMusicManager.PlayPhase2Music()
		get_tree().change_scene_to_file("res://scenes/worlds/phase_2.tscn")
	if Input.is_action_pressed("toggle_collisions"):
			var current_state = get_tree().is_debugging_collisions_hint()
			get_tree().set_debug_collisions_hint(not current_state)
