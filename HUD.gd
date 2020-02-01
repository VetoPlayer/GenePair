extends CanvasLayer

signal start_game


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	## Shows game over for 2 seconds,
	## Then return to the title screen and
	## After a brief pause show the play button
	show_message("Game Over!")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")	


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
