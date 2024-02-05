extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var about_text : RichTextLabel = get_node("VBoxContainer/ScrollContainer/VBoxContainer/Label2")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_to_start_screen_button_down():
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")




func _on_about_text_label_meta_clicked(meta):
	OS.shell_open(str(meta))
