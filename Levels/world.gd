extends Node2D

@export var next_level: PackedScene

func _ready() -> void:
	$"/root/GameManager/GUI".show()
	#GameManager.playBGM(load("res://Levels/assets/music/hurry_up_and_run.ogg"))
	GameManager.connect("level_completed", on_event_level_completed)

func on_event_level_completed():
	get_tree().paused = true
	if not next_level is PackedScene:
		await LevelTransition.fade_to_black()
		return
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	LevelTransition.fade_from_black()
