# Collection of important methods to handle direction and animation
extends "res://state_machine/state.gd"

#var left = "ui_left"
#var right = "ui_right"
#var up = "ui_up"
#var down = "ui_down"

var left = "ui_left"
var right = "ui_right"
var up = "ui_up"
var down = "ui_down"

var CONTROLS
		

func handle_input(event):
	if event.is_action_pressed("simulate_damage"):
		emit_signal("finished", "stagger")

func get_input_direction():
	CONTROLS = get_parent().CONTROLS
	if CONTROLS == null:
		return
	print(CONTROLS)
	print(get_parent().get_parent().get_path())
	print(get_parent().get_parent().isSet)
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed(CONTROLS["right"])) - int(Input.is_action_pressed(CONTROLS["left"]))
	input_direction.y = int(Input.is_action_pressed(CONTROLS["down"])) - int(Input.is_action_pressed(CONTROLS["up"]))
	return input_direction

func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
