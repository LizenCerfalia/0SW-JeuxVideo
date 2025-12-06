extends Control

func _ready() -> void:
	self.hide()

func pause_the_game():
	get_tree().paused = true
	self.show()
	$Continue.grab_focus()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	GlobalSoundManager.play_snap_sfx()
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	GlobalMusicManager.PlayMenuMusic()
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_continue_pressed() -> void:
	get_tree().paused = false
	self.hide()
