extends Control

@onready var transition = $Transition

# Called when the node enters the scene tree for the first time.
func _ready():
	transition.play("fade_in")
	var sound_button : CheckBox = get_node("VBoxContainer2/MarginContainer/HBoxContainer/Sound_Button") 
	sound_button.button_pressed = Globals.sound_enabled
	

func _on_start_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")



func _on_exit_button_button_down():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()



func _on_about_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/about_screen.tscn")
	



func _on_website_button_button_down():
	OS.shell_open("https://palashbauri.in/") 


func _on_sound_button_toggled(toggled_on):
	Globals.save_sound_settings(toggled_on)
