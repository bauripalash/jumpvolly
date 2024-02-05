extends RigidBody2D

signal hit_ground
var screen_size
@export var angular_force = 50000
var target = position + Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Soil":
		ball_ground_contact()

func ball_ground_contact():
	if $Timer.is_stopped():
		hit_ground.emit()
		$Timer.start()
		if Globals.sound_enabled:
			$SFX_Ball_Ground.play()
		

func _on_timer_timeout():
	$Timer.stop()
