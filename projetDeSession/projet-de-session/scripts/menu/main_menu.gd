extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/save_select.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/options.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_how_to_play_pressed() -> void:
	pass # Replace with function body.
