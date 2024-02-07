extends Control

@onready var transition = $Transition
var start_menu = preload("res://Scenes/start_menu.tscn")

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	transition.play("fade_out")


func _on_transition_animation_finished(anim_name):
	get_tree().change_scene_to_packed(start_menu)
