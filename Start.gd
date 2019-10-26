extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var choose_scene = preload("res://CharactorChoose.tscn")

func _on_Button_button_up():
	get_tree().change_scene_to(choose_scene)
