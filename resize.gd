extends Node

# don't forget to use stretch mode 'viewport' and aspect 'ignore'
onready var viewport = get_viewport()

func _ready():
	get_tree().connect("screen_resized", self, "_screen_resized")

func _screen_resized():
	var window_size = OS.get_window_size()
	viewport.set_size(window_size)
