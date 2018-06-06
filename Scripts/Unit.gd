extends KinematicBody2D

export var speed = 100

var selected = false setget set_selected
onready var box = $box
onready var bar = $bar
onready var label = $label

var move_p = false
var to_move = Vector2()
var path = PoolVector2Array()
var initialposition = Vector2()

signal was_selected
signal was_deselected

func set_selected(value):
	if selected != value:
		selected = value
		box.visible = value
		label.visible = value
		bar.visible = value
		if selected:
			emit_signal("was_selected", self)
		else:
			emit_signal("was_deselected", self)

func _ready():
	connect("was_selected", get_parent(), "select_unit")
	connect("was_deselected", get_parent(), "deselect_unit")
	box.visible = false
	label.visible = false
	bar.visible = false
	label.text = name
	bar.value = randi() % 90 + 10

func _process(delta):
	if move_p:
		path = get_viewport().get_node("World/nav").get_simple_path(position, to_move+Vector2(randi()%100, randi()%100))
		initialposition = position
		move_p = false
	if path.size() > 0:
		move_towards(initialposition, path[0], delta)

func move_towards(pos, point, delta):
	var v = (point - pos).normalized()
	v *= delta * speed
	position += v
	if position.distance_squared_to(point) < 9:
		path.remove(0)
		initialposition = position

func move_unit(point):
	to_move = point
	move_p = true

func _on_unit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				set_selected(not selected)

