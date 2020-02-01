extends CanvasLayer

signal start_game


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	
func show_game_over():
	## Shows game over for 2 seconds,
	## Then return to the title screen and
	## After a brief pause show the play button
	show_message("Game Over!")
	## TODO
	##yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()



func _on_StartButton_pressed():
	get_tree().change_scene("res://choose.tscn")

