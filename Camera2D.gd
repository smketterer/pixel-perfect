extends Camera2D

var fixed_toggle_point = Vector2(0,0)
var current_zoom = 1
var target_zoom = 1
export var ZOOM_LEVELS = [.25, .5, 1, 1.5, 2]
export var ZOOM_SPEED = 10

func _process(delta):
	self.global_position.x += (int(Input.is_action_pressed("camera_pan_right")) - int(Input.is_action_pressed("camera_pan_left"))) * 500 * current_zoom * delta
	self.global_position.y += (int(Input.is_action_pressed("camera_pan_down")) - int(Input.is_action_pressed("camera_pan_up"))) * 500 * current_zoom * delta
	
	if Input.is_action_just_pressed("mouse_middle"):
		var ref = get_viewport().get_mouse_position()
		fixed_toggle_point = ref
	if Input.is_action_pressed("mouse_middle"):
		var ref = get_viewport().get_mouse_position()
		self.global_position.x -= (ref.x - fixed_toggle_point.x) * current_zoom
		self.global_position.y -= (ref.y - fixed_toggle_point.y) * current_zoom
		fixed_toggle_point = ref
	if Input.is_action_just_released("mouse_scroll_up"):
		var current_zoom_index = ZOOM_LEVELS.find(target_zoom)
		if current_zoom_index > 0:
			target_zoom = ZOOM_LEVELS[current_zoom_index - 1]
	if Input.is_action_just_released("mouse_scroll_down"):
		var current_zoom_index = ZOOM_LEVELS.find(target_zoom)
		if current_zoom_index < ZOOM_LEVELS.size() - 1:
			target_zoom = ZOOM_LEVELS[current_zoom_index + 1]
	current_zoom = lerp(current_zoom, target_zoom, ZOOM_SPEED * delta)
	set_zoom(Vector2(current_zoom,current_zoom))
