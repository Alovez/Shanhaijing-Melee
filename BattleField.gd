extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var left = false
var right = false
var action = false
var screen_size
var player1 = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player1.role = $Xingtian
	player1.role.connect("shoot_remote", self, "_on_player_shoot_remote")
	player1.role.connect("input_shield", self, "_on_player_block_input")
	player1.role.connect("open_input", self, "_on_player_unblock_input")
	player1.remote = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for r in player1.remote:
		r.position.x += 5
		if r.position.x > screen_size.x:
			r.free()
			player1.remote.pop_front()
	if not player1.role.stop:
		if left and not action:
			player1.role.position.x -= 2
		if right and not action:
			player1.role.position.x += 2
	$"Energy/Mask".rect_size.x = 374 - 369.0 / 100.0 * player1.role.enegry
	
	
func _input(event):
	if event.is_action_pressed('ui_left'):
		left = true
	if event.is_action_pressed('ui_right'):
		right = true
	if event.is_action_released('ui_left'):
		left = false
	if event.is_action_released('ui_right'):
		right = false
	if event.is_action_pressed("kick") or event.is_action_pressed("punch"):
		action = true
	if event.is_action_released("kick") or event.is_action_released("punch"):
		action = false
		

func _on_player_shoot_remote(remote_scene):
	var new_remote = remote_scene.instance()
	add_child(new_remote)
	new_remote.position = player1.role.position
	new_remote.position.y += 150
	player1.remote.append(new_remote)

func _on_player_block_input():
	player1.role.stop = true
	
func _on_player_unblock_input():
	player1.role.stop = false