extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
	GameManager.playBGM(load("res://Levels/assets/music/hurry_up_and_run.ogg"))
	LevelTransition.fade_from_black()
