extends Control

func _on_save_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/character_select.tscn")

func _on_save_2_pressed() -> void:
	pass # Replace with function body.

func _on_save_3_pressed() -> void:
	pass # Replace with function body.

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
