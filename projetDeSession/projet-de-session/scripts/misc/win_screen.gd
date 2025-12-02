extends CanvasLayer

func _ready() -> void:
	self.hide()

func win_screen():
	get_tree().paused = true
	self.show()

func _on_button_pressed() -> void:
	get_tree().paused = false
	GlobalMusicManager.PlayMenuMusic()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
