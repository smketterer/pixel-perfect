extends KinematicBody2D

# Speed at which the sidekick will move
const MOVEMENT_SPEED = 96
# How close the sidekick must be to a point before moving on
const POINT_RADIUS = 5
var path
onready var nav = @"World/Navigation"
onready var line = @"World/Line2D"

# Performed on each step
func _process(delta):
	if path:
		var target = path[0]
		var direction = (target - position).normalized()
		position += direction * MOVEMENT_SPEED * delta
		if position.distance_to(target) < POINT_RADIUS:
			path.remove(0)
			if path.size() == 0:
				path = null
