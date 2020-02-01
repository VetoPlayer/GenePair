extends "../motion.gd"

var speed = 0.0
var velocity = Vector2()

func handle_input(event):
	if CONTROLS != null and event.is_action_pressed(CONTROLS["jump"]):
		print("jumping")
		emit_signal("finished", "jump")
	return .handle_input(event)
