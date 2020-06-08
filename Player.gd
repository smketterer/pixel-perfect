extends KinematicBody2D

# Speed at which the sidekick will move
const MOVEMENT_SPEED = 96
# How close the sidekick must be to a point before moving on
const POINT_RADIUS = 5
var path
onready var nav = get_node("../TileMap")


func _input(event):
	if Input.is_action_just_pressed("mouse_right"):
		path = nav.get_astar_path(position, event.position)
		if path:
			path.remove(0)
			print_debug('got path')

# Performed on each step
func _process(delta):
	if path:
		var target = path[0]
		var direction = (target - position).normalized()
		position += direction * MOVEMENT_SPEED * delta
		if position.distance_to(target) < POINT_RADIUS:
			# Remove first path point
			path.remove(0)
			if path.size() == 0:
				path = null
