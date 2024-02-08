extends RigidBody2D

signal hit_ground

func _on_body_entered(body : Node) -> void:
	if body.name == "Soil":
		ball_ground_contact()

func ball_ground_contact() -> void:
	if $Timer.is_stopped():
		hit_ground.emit()
		$Timer.start()
		if Globals.sound_enabled:
			$SFX_Ball_Ground.play()
		

func _on_timer_timeout() -> void:
	$Timer.stop()
