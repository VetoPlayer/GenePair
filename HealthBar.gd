extends Control

onready var health_bar = $HealthBar
var health_value = 100

func _on_health_updated(health, amount):
	  health_bar.value = health
func _on_max_health_updated(max_health):
	  health_bar.max_value = max_health
	
	
func update_health(damage):
	print("Updating Health....")
	health_value -= damage
	## TODO Check if health == 0
	health_bar.value = health_value
	