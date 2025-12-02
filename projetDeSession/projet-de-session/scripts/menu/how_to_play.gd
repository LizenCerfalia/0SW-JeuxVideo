extends Control


func _on_previous_pressed() -> void:
	$Page1.visible = true
	$Page2.visible = false


func _on_next_pressed() -> void:
	$Page2.visible = true
	$Page1.visible = false


func _on_back_pressed() -> void:
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
