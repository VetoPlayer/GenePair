extends Area2D

var first_player = false
## TODO: You do want to flip the player sprite if it's now the first player
signal hit(is_first_player, damage)
export var speed = 400 # pixel/sec - How fast the player will move.
var screen_size # Size of the game window
## Hack for double controls
var left = "ui_left"
var right = "ui_right"
var up = "ui_up"



# Called when the node enters the scene tree for the first time.
func _ready():
	## Actually hide the player at the very beginning of the game	
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed(left):
		velocity.x -= 1
	if Input.is_action_pressed(right):
		velocity.x += 1
	if Input.is_action_pressed(up):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		## Play the actual animation according to the velocity
		if velocity.x != 0:
			$Torso.animation = "walk"
			$Torso.flip_v = false
			$Torso.flip_h = velocity.x < 0
		if velocity.y != 0:
			$Torso.animation = "up"
			$Torso.flip_v = velocity.y > 0
		$Torso.play()
	else:
		$Torso.stop()
	# Actually update the player position
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func start(pos, is_first_player):
	## TODO: Add head, torso and legs type
	## When the game starts, move the player in the given position and reveal it.
	position = pos
	if is_first_player:
		first_player = true
		left = "first_left"
		right = "first_right"
		up = "first_up"
	show()
	$CollisionShape2D.disabled = false

func _on_Player_area_entered(area):
	print("I have been hit, emitting signal")
	## TODO: You should asks to the area2D just entered how much the damage is.
	## TODO: You do want to check out your current status, i.e. whether you are blocking
	emit_signal("hit", first_player, 20)
	## set_deferred: Disable collision shape only when it's safe to do so.
	## We actually want this to be disabled because we don't want to happen twice
	##$CollisionShape2D.set_deferred("disabled", true)
