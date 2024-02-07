extends CharacterBody2D

signal ball_hit

var screen_size
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -450.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


enum PState {
	Idle,
	WalkLeft,
	WalkRight,
}

var PlayerState = PState.Idle

var can_jump = false

func _ready():
	screen_size = get_viewport_rect().size
	$Timer.start()
	hide()
	start(position)
	
func start(pos):
	position = pos
	show()
	$AnimatedSprite2D.play()
	$CollisionShape2D.disabled = false
	
func _process(delta):
	if velocity.x != 0:
		$AnimatedSprite2D.speed_scale = 1
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.speed_scale = 0.4
		$AnimatedSprite2D.animation = "idle"

		
func should_jump(event):
	if can_jump and is_on_floor():
		return true
	else:
		return false

func _input(event):
	if event.is_action_pressed("move_left")or event.is_action_pressed("ui_left"):
		PlayerState = PState.WalkLeft
	elif event.is_action_pressed("move_right") or event.is_action_pressed("ui_right"):
		PlayerState = PState.WalkRight
	elif (event.is_action_released("move_left") or event.is_action_released("move_right") or 
			event.is_action_released("ui_left") or event.is_action_released("ui_right")):
		can_jump = true
		PlayerState = PState.Idle

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	match PlayerState: 
		PState.WalkRight:
			velocity.x = SPEED
		PState.WalkLeft:
			velocity.x = -SPEED
		PState.Idle:
			velocity.x = move_toward(velocity.x , 0 , SPEED)
			
	if can_jump:
		can_jump = false
		PlayerState = PState.Idle
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
	
	#var collision = move_and_collide(velocity * delta)
	
	#if collision:		
	#	if collision.get_collider().name == "Ball":
	#		emit_ball_hit()
	#	velocity = velocity.slide(collision.get_normal())	
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO , screen_size)
	move_and_slide()
	
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider().name == "Ball":
			emit_ball_hit()
	
func play_ball_player_sfx():
	if Globals.sound_enabled:
		$SFX_Ball_Player.play()
	

func emit_ball_hit():
	if $Timer.is_stopped():
		play_ball_player_sfx()
		ball_hit.emit()
		$Timer.start()
	else:
		return


func _on_timer_timeout():
	$Timer.stop()
