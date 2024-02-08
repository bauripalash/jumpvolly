extends CanvasLayer

signal ig_retry_click
signal ig_return_click
signal ig_mainmenu_click

func _ready() -> void:
	var sound_check : CheckBox = $VBoxContainer/IG_Sound_Button
	sound_check.button_pressed = Globals.sound_enabled

func _on_ig_retry_button_button_down() -> void:
	ig_retry_click.emit()

func _on_ig_return_button_button_down() -> void:
	ig_return_click.emit()
	
func _on_ig_main_menu_button_button_down() -> void:
	ig_mainmenu_click.emit()

func _on_ig_sound_button_toggled(toggled_on : bool) -> void:
	Globals.save_sound_settings(toggled_on)
