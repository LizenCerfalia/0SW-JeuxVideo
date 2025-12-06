extends Control

@onready var Page1 = $Page1
@onready var Page2 = $Page2
@onready var Page3 = $Page3

func _on_previous_pressed() -> void:
	if Page2.visible:
		Page1.visible = true
		Page2.visible = false
	if Page3.visible:
		Page2.visible = true
		Page3.visible = false


func _on_next_pressed() -> void:
	if Page2.visible:
		Page3.visible = true
		Page2.visible = false
	if Page1.visible:
		Page2.visible = true
		Page1.visible = false


func _on_back_pressed() -> void:
	GlobalSoundManager.play_snap_sfx()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
