extends CanvasLayer

func _ready() -> void:
	self.hide()

func win_screen():
	get_tree().paused = true
	self.show()

func _on_button_pressed() -> void:
	get_tree().paused = false
	GlobalMusicManager.PlayMenuMusic()
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
