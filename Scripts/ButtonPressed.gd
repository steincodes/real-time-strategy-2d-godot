extends TextureButton

signal was_pressed

func connect_me(obj, unit_name):
	name = unit_name
	$label.text = unit_name
	connect("was_pressed", obj, "was_pressed", [self])

func _pressed():
	emit_signal("was_pressed")