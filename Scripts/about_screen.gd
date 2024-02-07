extends Control

func _on_return_to_start_screen_button_down():
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

func _on_about_text_label_meta_clicked(meta):
	OS.shell_open(str(meta))
