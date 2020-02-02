extends Control


signal dead_player

onready var health_bar = $HealthBar
onready var health_value = 100

func _on_health_updated(health, amount):
	  health_bar.value = health
func _on_max_health_updated(max_health):
	  health_bar.max_value = max_health
	
	
func update_health(damage):
	health_value -= damage
	## TODO Check if health == 0
	
	if(health_value <= 0.0):
	  health_bar.value = 0.0
	  health_bar.max_value = 0.0
	  print ("Done xd")
	  emit_signal("dead_player")
	else:
	  health_bar.value = health_value
	## Update health value
	health_bar.value = health_value

	
