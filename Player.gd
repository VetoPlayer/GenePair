extends Area2D

signal hit

export var speed = 400 # pixel/sec - How fast the player will move.
var screen_size # Size of the game window
# Called when the node enters the scene tree for the first time.
func _ready():
	## Actually hide the player at the very beginning of the game	
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		## Play the actual animation according to the velocity
		if velocity.x != 0:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = velocity.x < 0
		if velocity.y != 0:
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_v = velocity.y > 0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	# Actually update the player position
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body):
	## Player disappears after being hit
	hide()
	emit_signal("hit")
	## set_deferred: Disable collision shape only when it's safe to do so.
	## We actually want this to be disabled because we don't want to happen twice
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	## When the game starts, move the player in the given position and reveal it.
	position = pos
	show()
	$CollisionShape2D.disabled = false