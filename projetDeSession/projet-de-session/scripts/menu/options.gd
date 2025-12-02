extends Control

const SAVE_FILE_DIR = "user://save/"
const SAVE_FILE_NAME = "sound_data.tres"
const SAVE_FILE_PATH = SAVE_FILE_DIR + SAVE_FILE_NAME

var BGMVolume = 0.8 
var SFXVolume = 0.8

var sound_data = SoundData.new()

func _ready() -> void:
	if ResourceLoader.exists(SAVE_FILE_PATH):

		var loaded_resource = ResourceLoader.load(SAVE_FILE_PATH)
		if loaded_resource is SoundData:
			sound_data = loaded_resource.duplicate(true)
			BGMVolume = sound_data.BGMvolume
			SFXVolume = sound_data.SFXVolume
			
	update_ui()
	update_sound()

func update_ui():
	$BGM.value = BGMVolume
	$SFX.value = SFXVolume
	
func update_sound():
	GlobalMusicManager.volume = BGMVolume
	GlobalSoundManager.volume = SFXVolume
	GlobalMusicManager.update_music_volume()
	GlobalSoundManager.update_sfx_volume()
	
func save_sound() -> void:
	var sound_data_res: SoundData

	if ResourceLoader.exists(SAVE_FILE_PATH):
		var loaded_resource = ResourceLoader.load(SAVE_FILE_PATH)
		if loaded_resource is SoundData:
			sound_data_res = loaded_resource.duplicate(true)
		else:
			sound_data_res = SoundData.new()
	else:
		sound_data_res = SoundData.new()

	sound_data_res.BGMvolume = GlobalMusicManager.volume
	sound_data_res.SFXVolume = GlobalSoundManager.volume

	ResourceSaver.save(sound_data_res, SAVE_FILE_PATH)
	
func _on_back_pressed() -> void:
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_save_changes_pressed() -> void:
	update_sound()
	save_sound()
	GlobalSoundManager.play_snap_sfx()

func _on_bgm_value_changed(value: float) -> void:
	BGMVolume = value

func _on_sfx_value_changed(value: float) -> void:
	SFXVolume = value
