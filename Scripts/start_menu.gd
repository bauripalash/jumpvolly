extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_start_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")



func _on_exit_button_button_down():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()



func _on_about_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/about_screen.tscn")
	



func _on_website_button_button_down():
	OS.shell_open("https://palashbauri.in/") 
