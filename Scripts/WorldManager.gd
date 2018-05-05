extends Node2D

var selected_units = [] #objects

onready var button = preload("res://Scenes/Button.tscn")
var buttons = [] # strings 

func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)
	#print("selected %s" % unit.name)
	create_buttons()

func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)
	create_buttons()

func create_buttons():
	delete_buttons()
	for unit in selected_units:
		if not buttons.has(unit.name):
			var but = button.instance()
			but.connect_me(self, unit.name)
			but.rect_position = Vector2(buttons.size() * 64 + 32 , -120)
			$'UI/Base'.add_child(but)
			buttons.append(unit.name)

func delete_buttons():
	for but in buttons:
		if $'UI/Base'.has_node(but):
			var b = $'UI/Base'.get_node(but)
			b.queue_free()
			$'UI/Base'.remove_child(b)
	buttons.clear()

func was_pressed(obj):
	for unit in selected_units:
		if unit.name == obj.name:
			unit.set_selected(false)
			break

func _ready():
	pass

func _process(delta):
	pass
