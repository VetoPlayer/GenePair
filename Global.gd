extends Node2D


var first_animals = []
var second_animals = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_first_animals(animal):
	first_animals.push_back(animal)

func add_second_animals(animal):
	second_animals.push_back(animal)
	
func mix_randomly():
	first_animals.shuffle()
	second_animals.shuffle()