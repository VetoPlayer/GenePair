extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var g = get_node("/root/Global")


func _on_StartButton_pressed():
	get_tree().change_scene("res://Main.tscn")
