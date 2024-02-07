extends Node2D



var score = 0
@export var health = 1

var h_full = preload("res://Artworks/HUD/heart_full.png")
var h_half = preload("res://Artworks/HUD/heart_half.png")
var h_empty = preload("res://Artworks/HUD/heart_empty.png")


func _ready():
	update_health(health)
	var touch_controls : Control = get_node("Game/Touch_Controls")
	var platform = OS.get_name()
	print(platform)
	if (platform.begins_with("Android") 
	or platform.begins_with("iOS") 
	or platform.begins_with("HTML5")
	or platform.begins_with("Web")):
		touch_controls.visible = true
			

func update_health(value):
	var hcon = get_node("Game/HUD/Health_Control/MarginContainer/Health_Container")
	for i in hcon.get_child_count():
		if value > i * 2 + 1:
			hcon.get_child(i).texture = h_full
		elif value > i * 2:
			hcon.get_child(i).texture = h_half
		else:
			hcon.get_child(i).texture = h_empty
	

func _on_player_ball_hit():
	score += 1
	$Game/HUD/Score_Control/Score_Label.set_text("%04d" % score)
	print("Score -> %03d" %score)

func handle_game_over():
	if score > Globals.high_score:
		Globals.save_high_score(score)
		
	
	var ys_label = ("Your Score : %02d" % score)
	get_node("GameOver_Layout/Game_Over_Container/Your_Score").set_text(ys_label)
	var hs_label = ("High Score : %02d" % Globals.high_score)
	get_node("GameOver_Layout/Game_Over_Container/High_Score").set_text(hs_label)
	$GameOver_Layout.show()
	get_tree().paused = true
	hide()

func _on_ball_hit_ground():
	if health != 0:
		health -= 1
		print("Health -> " , health)
		update_health(health)
	else:
		handle_game_over()
		health = -1
		


func _on_game_over_layout_go_menu_click():
	show()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")



func _on_in_game_menu_button_pressed():
	hide()
	get_node("InGameMenu").visible = true
	get_tree().paused = true
	
	
func _on_in_game_menu_ig_retry_click():
	show()
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	

func _on_in_game_menu_ig_return_click():
	show()
	get_node("InGameMenu").visible = false
	get_tree().paused = false
	

func _on_in_game_menu_ig_mainmenu_click():
	show()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")


func _on_game_over_layout_restart_click():
	show()
	get_tree().paused = false
	get_tree().reload_current_scene()



func _on_leftbutton_button_down():
	var cancel_event = InputEventAction.new()
	cancel_event.action = "move_left"
	cancel_event.pressed = true
	Input.parse_input_event(cancel_event)


func _on_leftbutton_button_up():
	var cancel_event = InputEventAction.new()
	cancel_event.action = "move_left"
	cancel_event.pressed = false
	Input.parse_input_event(cancel_event)



func _on_left_button_button_down():
	var left_touch_event = InputEventAction.new()
	left_touch_event.action = "move_left"
	left_touch_event.pressed = true
	Input.parse_input_event(left_touch_event)


func _on_left_button_button_up():
	var left_touch_event = InputEventAction.new()
	left_touch_event.action = "move_left"
	left_touch_event.pressed = false
	Input.parse_input_event(left_touch_event)



func _on_right_button_button_down():
	var right_touch_event = InputEventAction.new()
	right_touch_event.action = "move_right"
	right_touch_event.pressed = true
	Input.parse_input_event(right_touch_event)


func _on_right_button_button_up():
	var right_touch_event = InputEventAction.new()
	right_touch_event.action = "move_right"
	right_touch_event.pressed = false
	Input.parse_input_event(right_touch_event)
