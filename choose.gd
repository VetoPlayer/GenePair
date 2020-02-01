extends CanvasLayer

## Preload the global script in such a way that we are able to update its values
onready var g = get_node("/root/Global")

func _on_StartButton_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_Trex_pressed():
	g.add_first_animals("trex")


func _on_Chicken_pressed():
	g.add_first_animals("chicken")
