extends Button

var is_on := false
var x := 0
var y := 0

signal tile_pressed(x, y)

func _ready():
	pressed.connect(_emit_pressed)
	update_visual()

func _emit_pressed():
	emit_signal("tile_pressed", x, y)

func toggle():
	is_on = !is_on
	update_visual()

func update_visual():
	self.modulate = Color(0.0, 18.892, 0.0, 1.0) if is_on else Color(18.892, 0.0, 0.0, 1.0)
