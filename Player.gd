extends Area2D

var first_player = false
## TODO: You do want to flip the player sprite if it's now the first player
signal hit(is_first_player, damage)
export var speed = 400 # pixel/sec - How fast the player will move.
var screen_size # Size of the game window
## Hack for double controls
var left = "ui_left"
var right = "ui_right"
var up_attack = "ui_up"
var up_block = "ui_down"

var is_blocking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	## Actually hide the player at the very beginning of the game
	## Read about what kind of configuration the each is suposed to have from a global script
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed(left):
		velocity.x -= 1
	if Input.is_action_pressed(right):
		velocity.x += 1
	if Input.is_action_pressed(up_attack):
		$Torso.animation = "torso_attack"
		$Torso.play()
	if Input.is_action_pressed(up_block):
		is_blocking = true
		$Torso.animation = "torso_block"
		$Torso.play()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		## Play the actual animation according to the velocity
		##if velocity.x != 0:
		##	$Torso.flip_v = false
		##	$Torso.flip_h = velocity.x < 0
		##if velocity.y != 0:
		##	$Torso.animation = "up"
		##	$Torso.flip_v = velocity.y > 0
	#else:
		#$Torso.stop()
	# Actually update the player position
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func start(pos, is_first_player, head, torso, legs):
	## When the game starts, move the player in the given position and reveal it.
	position = pos
	show()
	
	if is_first_player:
		$Head.flip_h = true
		$Torso.flip_h = true
		$Legs.flip_h = true
		first_player = true
		## Update the commands to be the first player ones.
		left = "first_left"
		right = "first_right"
		up_attack = "first_attack"
		up_block = "first_down"
	else:
		#Flip the sprites
		$Torso.flip_h = false

	$CollisionShape2D.disabled = false

func _on_Player_area_entered(area):
	if not is_blocking and not area.is_blocking:
		emit_signal("hit", first_player, 20)
	## set_deferred: Disable collision shape only when it's safe to do so.
	## We actually want this to be disabled because we don't want to happen twice
	#$CollisionShape2D.set_deferred("disabled", true)


func _on_Torso_animation_finished():
	$Torso.stop()
	is_blocking = false
	
