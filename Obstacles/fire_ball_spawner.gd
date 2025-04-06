extends Node2D

#@export var fire_ball: PackedScene
@export var fire_ball = load("res://Obstacles/fire_ball.tscn")
	
func spawn_fire():
	var instance = fire_ball.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation 
	#instance.zdex = z_index -1
	owner.add_child.call_deferred(instance)

func _on_timer_timeout() -> void:
	spawn_fire()
