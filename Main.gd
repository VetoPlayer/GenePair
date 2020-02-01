extends Node2D

export (PackedScene) var Mob
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player1.start($StartPosition1.position, true)
	$Player2.start($StartPosition2.position, false)
	$HUD.show_message("Get Ready!")
	$Music.play()



func _on_Player_hit(is_first_player, damage):
	## When the player is hit, the game is over
	print("I see the player being hit")
	print(damage)
	##$HUD.show_game_over()
	$DeathSound.play()
	$Music.stop()
	
	


func new_player_selection():
	get_tree().change_scene("res://choose.tscn")


func _on_HUD_start_game():
	## This one afterwards will need to be performed if it's the first time
	new_player_selection()
