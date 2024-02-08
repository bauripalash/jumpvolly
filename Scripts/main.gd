extends Node2D



var score : int = 0
@export var health : int = 10	

var h_full : CompressedTexture2D = preload("res://Artworks/HUD/heart_full.png")
var h_half : CompressedTexture2D = preload("res://Artworks/HUD/heart_half.png")
var h_empty : CompressedTexture2D = preload("res://Artworks/HUD/heart_empty.png")

@onready var debug_controls : Control = $Game/HUD/Debug_Controls
@onready var touch_controls : Control = $Game/Touch_Controls

func _ready() -> void:
	if Globals.DEBUG:
		debug_controls.visible = true
	
	update_health(health)
	
	var platform : String = OS.get_name()
	#print(platform)
	if (platform.begins_with("Android") 
	or platform.begins_with("iOS") 
	or platform.begins_with("HTML5")
	or platform.begins_with("Web")):
		touch_controls.visible = true
	
func _process(delta: float) -> void:
	if Globals.DEBUG:
		$Game/HUD/Debug_Controls/MCont/VCont/FPS_Label.set_text("FPS : " + 
									str(Engine.get_frames_per_second()))

func update_health(value : int) -> void:
	var hcon : HBoxContainer = $Game/HUD/Health_Control/MarginContainer/Health_Container
	for i : int in hcon.get_child_count():
		if value > i * 2 + 1:
			hcon.get_child(i).texture = h_full
		elif value > i * 2:
			hcon.get_child(i).texture = h_half
		else:
			hcon.get_child(i).texture = h_empty
	

func _on_player_ball_hit() -> void:
	score += 1
	var score_label : Label = $Game/HUD/Score_Control/Score_Label
	score_label.set_text("%04d" % score)
	

func handle_game_over() -> void:
	if score > Globals.high_score:
		Globals.save_high_score(score)
	
	var your_score_label : Label = $GameOver_Layout/Game_Over_Container/Your_Score
	var ys_label : String = ("Your Score : %02d" % score)
	your_score_label.set_text(ys_label)
	
	var hs_label : String = ("High Score : %02d" % Globals.high_score)
	var high_score_label : Label = $GameOver_Layout/Game_Over_Container/High_Score
	high_score_label.set_text(hs_label)
	
	var game_over_layer : CanvasLayer = $GameOver_Layout
	game_over_layer.show()
	get_tree().paused = true
	hide()

func _on_ball_hit_ground() -> void:
	if health != 0:
		health -= 1
		print("Health -> " , health)
		update_health(health)
	else:
		handle_game_over()
		health = -1
		


func _on_game_over_layout_go_menu_click() -> void:
	show()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")



func _on_in_game_menu_button_pressed() -> void:
	hide()
	$InGameMenu.visible = true
	get_tree().paused = true
	
	
func _on_in_game_menu_ig_retry_click() -> void:
	show()
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	

func _on_in_game_menu_ig_return_click() -> void:
	show()
	$InGameMenu.visible = false
	get_tree().paused = false
	

func _on_in_game_menu_ig_mainmenu_click() -> void:
	show()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")


func _on_game_over_layout_restart_click() -> void:
	show()
	get_tree().paused = false
	get_tree().reload_current_scene()



func _on_leftbutton_button_down() -> void:
	var cancel_event : InputEventAction = InputEventAction.new()
	cancel_event.action = "move_left"
	cancel_event.pressed = true
	Input.parse_input_event(cancel_event)


func _on_leftbutton_button_up() -> void:
	var cancel_event : InputEventAction = InputEventAction.new()
	cancel_event.action = "move_left"
	cancel_event.pressed = false
	Input.parse_input_event(cancel_event)



func _on_left_button_button_down() -> void:
	var left_touch_event : InputEventAction = InputEventAction.new()
	left_touch_event.action = "move_left"
	left_touch_event.pressed = true
	Input.parse_input_event(left_touch_event)


func _on_left_button_button_up() -> void:
	var left_touch_event : InputEventAction = InputEventAction.new()
	left_touch_event.action = "move_left"
	left_touch_event.pressed = false
	Input.parse_input_event(left_touch_event)



func _on_right_button_button_down() -> void:
	var right_touch_event : InputEventAction = InputEventAction.new()
	right_touch_event.action = "move_right"
	right_touch_event.pressed = true
	Input.parse_input_event(right_touch_event)


func _on_right_button_button_up() -> void:
	var right_touch_event : InputEventAction = InputEventAction.new()
	right_touch_event.action = "move_right"
	right_touch_event.pressed = false
	Input.parse_input_event(right_touch_event)
