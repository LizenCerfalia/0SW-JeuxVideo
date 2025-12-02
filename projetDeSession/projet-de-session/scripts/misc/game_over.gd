extends CanvasLayer

@onready var players = get_tree().get_nodes_in_group("players")

func _process(delta: float) -> void:
	var i = 0
	for player in players:
		if player.is_dead():
			i += 1
	if i == 4:
		game_over()

func _ready() -> void:
	self.hide()

func game_over():
	get_tree().paused = true
	self.show()


func _on_restart_pressed() -> void:
	get_tree().paused = false
	GlobalSoundManager.play_snap_sfx()
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	GlobalMusicManager.PlayMenuMusic()
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
