extends CanvasLayer
class_name GameOverUI

signal restart_click
signal go_menu_click


func _on_restart_button_button_down() -> void:
	restart_click.emit()




func _on_menu_button_button_down() -> void:
	go_menu_click.emit()
