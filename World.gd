extends Node2D

onready var player = $Navigation/Entities/Player
onready var nav = $Navigation
onready var line = $Line2D

func _input(event):
	if Input.is_action_just_pressed("mouse_right"):
		var path = nav.get_simple_path(player.position, get_global_mouse_position(), false)
		line.points = path
		print(path.size())
		if path:
			path.remove(0)
		player.path = path
