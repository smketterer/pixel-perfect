extends KinematicBody2D

const TARGET_FPS = 60
const ACCELERATION = 8
const MAX_SPEED = 68
const FRICTION = 15
const AIR_RESISTANCE = 1
const GRAVITY = 6
const JUMP_FORCE = 155

var motion = Vector2.ZERO

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	
	if is_on_floor():
		if x_input != 0:
			sprite.play("walk")
		else:
			sprite.play("stand")
			motion.x = lerp(motion.x, 0, FRICTION * delta)
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		if sprite.animation != "jump":
			print_debug(sprite.animation)
			sprite.play("jump")
		
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	motion = move_and_slide(motion, Vector2.UP)
