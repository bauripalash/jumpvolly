extends Node2D



var score = 0
@export var health = 1

var h_full = preload("res://Artworks/HUD/heart_full.png")
var h_half = preload("res://Artworks/HUD/heart_half.png")
var h_empty = preload("res://Artworks/HUD/heart_empty.png")
var back_menu_icon = preload("res://Artworks/HUD/back_menu_btn.png")
var retry_menu_icon = preload("res://Artworks/HUD/retry_menu_btn.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOver_Layout.hide()
	#load_high_score()
	update_health(health)
	

	

func update_health(value):
	var hcon = get_node("Game/HUD/Health_Control/MarginContainer/Health_Container")
	for i in hcon.get_child_count():
		if value > i * 2 + 1:
			hcon.get_child(i).texture = h_full
		elif value > i * 2:
			hcon.get_child(i).texture = h_half
		else:
			hcon.get_child(i).texture = h_empty
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("retry_click"):
		get_tree().reload_current_scene()


func _on_player_ball_hit():
	score += 1
	$Game/HUD/Score_Control/Score_Label.set_text("%04d" % score)
	print("Score -> %03d" %score)

func handle_game_over():
	#$Game/Player/CollisionShape2D.disabled = true 
	#$Game/Ball/CollisionShape2D.disabled = true
	#get_node("Game").process_mode = Node.PROCESS_MODE_DISABLED
	#get_node("Game/HUD/Score_Control").visible = false
	#get_node("Game/HUD/Health_Control").visible = false
	#get_node("Game/Retry_Button_Control").visible = false
	#get_node("Game").set_deferred("process_mode" , Node.PROCESS_MODE_DISABLED)
	
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
