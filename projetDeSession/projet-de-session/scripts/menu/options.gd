extends Control

@export var BGMVolume = 0.8 
@export var SFXVolume = 0.8

func _ready() -> void:
	$BGM.value = BGMVolume
	$SFX.value = SFXVolume

func update_sound():
	GlobalMusicManager.volume = BGMVolume
	GlobalSoundManager.volume = SFXVolume
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_save_changes_pressed() -> void:
	GlobalMusicManager.volume = BGMVolume
	GlobalSoundManager.volume = SFXVolume
	GlobalMusicManager.update_music_volume()
	GlobalSoundManager.update_sfx_volume()

func _on_bgm_value_changed(value: float) -> void:
	BGMVolume = value

func _on_sfx_value_changed(value: float) -> void:
	SFXVolume = value
