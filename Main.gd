extends Node2D

export (PackedScene) var Mob
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hit():
	## When the player is hit, the game is over
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()
	$Music.stop()
	
	
func new_game():
	score = 0
	$Player1.start($StartPosition1.position, true)
	$Player2.start($StartPosition2.position, false)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)



func _on_MobTimer_timeout():
	 #Choose a random location
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create a mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.position = $MobPath/MobSpawnLocation.position
	## Set Linear velocity
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed),0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)



func _on_HUD_start_game():
	new_game()
