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
			WorldState.BGM = BGMVolume
			WorldState.SFX = SFXVolume
	update_sound()

func update_sound():
	GlobalMusicManager.volume = BGMVolume
	GlobalSoundManager.volume = SFXVolume
	GlobalMusicManager.update_music_volume()
	GlobalSoundManager.update_sfx_volume()

func _on_start_pressed() -> void:
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/save_select.tscn")

func _on_options_pressed() -> void:
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/options.tscn")

func _on_quit_pressed() -> void:
	GlobalSoundManager.play_snap_sfx()
	get_tree().quit()

func _on_how_to_play_pressed() -> void:
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/how_to_play.tscn")
