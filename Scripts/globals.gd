extends Node

@export var DEBUG : bool = false
var sound_enabled  : bool = true
var high_score : int = 0

const SOUND_SETTINGS_FILE : String = "user://sound.jumpvolly.save"
const HIGH_SCORE_FILE : String = "user://score.jumpvolly.save"

func load_sound_settings() -> void:
	if not FileAccess.file_exists(SOUND_SETTINGS_FILE):
		return
	var f : FileAccess = FileAccess.open(SOUND_SETTINGS_FILE , FileAccess.READ)
	var sval : int = f.get_8()
	if sval == 0:
		sound_enabled = false
	else:
		return
		
func save_sound_settings(value : bool) -> void:
	var f : FileAccess = FileAccess.open(SOUND_SETTINGS_FILE , FileAccess.WRITE)
	f.store_8(int(value))
	sound_enabled = value

func get_high_score() -> int:
	if not FileAccess.file_exists(HIGH_SCORE_FILE):
		return 0
	var f : FileAccess = FileAccess.open(HIGH_SCORE_FILE , FileAccess.READ)
	var raw_hs : String = f.get_line()
	if !raw_hs.is_empty():
		return int(raw_hs)
	else:
		return 0
		
func save_high_score(hs : int) -> void:
	var f : FileAccess = FileAccess.open(HIGH_SCORE_FILE , FileAccess.WRITE)
	f.store_line(str(hs))
	high_score = hs

func _ready() -> void:
	load_sound_settings()
	high_score = get_high_score()
	
	

