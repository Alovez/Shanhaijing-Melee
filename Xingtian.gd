extends Node2D

signal shoot_remote
signal input_shield
signal open_input

var xingtian_remote = preload("res://XindtianRemote.tscn")
var screen_size
var playback

var enegry = 100
var enegry_modulus = 1
var awareness = 0
var awareness_modulus = 0.5
var stop = false
var tired = false


func _ready():
	screen_size = get_viewport_rect().size
	playback = $AnimationTree.get("parameters/playback")
	playback.start('Idle')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	enegry += delta * enegry_modulus
	enegry = clamp(enegry, 0, 100)
	awareness -= delta * awareness_modulus
	awareness = clamp(awareness, 0, 100)
	if enegry < 1:
		playback.travel('tired')
		tired = true
	if enegry < 10:
		stop = tired
	if tired and enegry > 10:
		playback.travel('post_tired')
		tired = false
		stop = tired
	if not tired and Input.is_action_pressed("ui_right") and not Input.is_action_pressed("punch") and not Input.is_action_pressed("kick") and not Input.is_action_pressed("remote"):
		playback.travel('walk')
	
func _input(event):
	if not tired:
		if event is InputEventKey and event.pressed:
			if event.scancode == KEY_Z:
				playback.travel('punch')
			elif event.scancode == KEY_X:
				playback.travel('kick')
			elif event.scancode == KEY_C:
				playback.travel('remote')
		if event.is_action_pressed('ui_right'):
			playback.travel('walk')
		if event.is_action_released('ui_right'):
			playback.travel('Idle')

func cost_enegry(unit):
	enegry -= unit
	print(enegry)

func block_input():
	stop = true

func unblock_input():
	stop = false

func shoot_remote():
	emit_signal("shoot_remote", xingtian_remote)

func _on_Area2D_body_entered(body):
	print("Hitted")
