extends CharacterBody2D
class_name Enemy

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2
var in_air = false
var in_wall = false

func _ready():
	left_bounds = self.position + Vector2(-200, 0)
	right_bounds = self.position + Vector2(200, 0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		var P_state = body.check_state()
		if P_state == true:
			_on_death()
		#Option 1: check the variable in player state machine
		#if player state == attack
			#_on_death()
		else:
			body.adjust_health(1,"down")

func _on_death():
	# Play external death animation
	# Play death sound'
	queue_free()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
