extends HBoxContainer
class_name HealthView

var h_full = preload("res://Artworks/HUD/heart_full.png")
var h_half = preload("res://Artworks/HUD/heart_half.png")
var h_empty = preload("res://Artworks/HUD/heart_empty.png")

func update_health(value):
	for i in get_child_count():
		if value > i * 2 + 1:
			get_child(i).texture = h_full
		elif value > i * 2:
			get_child(i).texture = h_half
		else:
			get_child(i).texture = h_empty
