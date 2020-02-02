extends Node2D

export (PackedScene) var Mob
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	## Let's get the global variables about the players
	## and instantiate them accordingly
	var g = get_node("/root/Global")
	## First Player
	var f = g.first_animals
	## Second Player
	var sec = g.second_animals
	## TODO: Reenable these!
	$Player1.start($StartPosition1.position, true, f[0], f[1],  f[2])
	$Player2.start($StartPosition2.position, false, sec[0], sec[1], sec[2])
	$Music.play()



func _on_Player_hit(is_first_player, damage):
	## When the player is hit, the game is over
	##$HUD.show_game_over()
	
	if(is_first_player):
		$HealthBar1.update_health(damage)
	else:
		$HealthBar2.update_health(damage)
	#deathSound effect is being 
	$DeathSound.play()
	#$Music.stop()
	
	


func new_player_selection():
	get_tree().change_scene("res://choose.tscn")


func _on_HUD_start_game():
	## This one afterwards will need to be performed if it's the first time
	new_player_selection()


func _on_HealthBar1_dead_player():
	print("Game is Over!")


func _on_Music_finished():
	$Music.play()# Replace with function body.
