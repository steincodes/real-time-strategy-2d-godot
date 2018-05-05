extends Camera2D

export var panSpeed = 10.0
export var speed = 10.0
export var zoomspeed = 10.0
export var zoommargin = 0.1

export var zoomMin = 0.25
export var zoomMax = 3.0
export var marginX = 200.0
export var marginY = 200.0

var mousepos = Vector2()
var zoompos = Vector2()
var zoomfactor = 1.0
var zooming = false

func _ready():
	pass


func _process(delta):

	#smooth movement
	var inpx = (int(Input.is_action_pressed("ui_right"))
	                   - int(Input.is_action_pressed("ui_left")))
	var inpy = (int(Input.is_action_pressed("ui_down"))
	                   - int(Input.is_action_pressed("ui_up")))
	position.x = lerp(position.x, position.x + inpx *speed * zoom.x,speed * delta)
	position.y = lerp(position.y, position.y + inpy *speed * zoom.y,speed * delta)

	if Input.is_key_pressed(KEY_CONTROL):
		#check mousepos
		if mousepos.x < marginX:
			position.x = lerp(position.x, position.x - abs(mousepos.x - marginX)/marginX * panSpeed * zoom.x, panSpeed * delta)
		elif mousepos.x > OS.window_size.x - marginX:
			position.x = lerp(position.x, position.x + abs(mousepos.x - OS.window_size.x + marginX)/marginX *  panSpeed * zoom.x, panSpeed * delta)
		if mousepos.y < marginY:
			position.y = lerp(position.y, position.y - abs(mousepos.y - marginY)/marginY * panSpeed * zoom.y, panSpeed * delta)
		elif mousepos.y > OS.window_size.y - marginY:
			position.y = lerp(position.y, position.y + abs(mousepos.y - OS.window_size.y + marginY)/marginY * panSpeed * zoom.y, panSpeed * delta)
	
	#zoom in
	zoom.x = lerp(zoom.x, zoom.x * zoomfactor, zoomspeed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomfactor, zoomspeed * delta)

	zoom.x = clamp(zoom.x, zoomMin, zoomMax)
	zoom.y = clamp(zoom.y, zoomMin, zoomMax)

	if not zooming:
		zoomfactor = 1.0

func _input(event):

	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.button_index == BUTTON_WHEEL_UP:
				zoomfactor -= 0.01 * zoomspeed
				zoompos = get_global_mouse_position()
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoomfactor += 0.01 * zoomspeed
				zoompos = get_global_mouse_position()
		else:
			zooming = false
	
	if event is InputEventMouse:
		mousepos = event.position


