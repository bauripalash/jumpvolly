extends CanvasLayer
class_name GameOverUI

signal restart_click
signal go_menu_click


func _on_restart_button_button_down():
	restart_click.emit()




func _on_menu_button_button_down():
	go_menu_click.emit()
