extends Control


signal dead_player

onready var health_bar = $HealthBar
var health_value = 100

func _on_health_updated(health, amount):
	  health_bar.value = health
func _on_max_health_updated(max_health):
	  health_bar.max_value = max_health
	
	
func update_health(damage):
	health_value -= damage
	## Update health value
	health_bar.value = health_value
	if health_value <= 0:
		emit_signal("dead_player")
	
	