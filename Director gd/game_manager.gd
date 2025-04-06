extends Node

signal level_completed

var coins = 0
var score = 0
var health = 3
var goal_open = false
var enemy_count = 0

func playSFX(stream):
	$SFX.stream = stream
	$SFX.play()
	
func playBGM(stream):
	$BGM.stream = stream
	$BGM.play()

func _process(delta: float) -> void:
	$"GUI/GemValue".text = str(coins)
	$"GUI/ScoreValue".text = str(score)
	$"GUI/Health/Value".text = str(health)
