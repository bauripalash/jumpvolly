extends CanvasLayer

signal ig_retry_click
signal ig_return_click
signal ig_mainmenu_click



# Called when the node enters the scene tree for the first time.
func _ready():
	var sound_check : CheckBox = get_node("VBoxContainer/IG_Sound_Button")
	sound_check.button_pressed = Globals.sound_enabled


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ig_retry_button_button_down():
	ig_retry_click.emit()


func _on_ig_return_button_button_down():
	ig_return_click.emit()
	

func _on_ig_main_menu_button_button_down():
	ig_mainmenu_click.emit()



func _on_ig_sound_button_toggled(toggled_on):
	Globals.save_sound_settings(toggled_on)
