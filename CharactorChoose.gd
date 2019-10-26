extends Control

var battle = preload("res://BattleField.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_XingTian_button_up():
	var choosen_charactor = File.new()
	choosen_charactor.open("user://choosen.save", File.WRITE)
	choosen_charactor.store_line("res://Xingtian.tscn")
	choosen_charactor.close()
	

func _on_Next_button_up():
	get_tree().change_scene_to(battle)


func _on_None_button_up():
	var choosen_charactor = File.new()
	choosen_charactor.open("user://choosen.save", File.WRITE)
	choosen_charactor.store_line("")
	choosen_charactor.close()
