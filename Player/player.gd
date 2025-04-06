extends CharacterBody2D
class_name Player

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Change animations
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	move_and_slide()

func adjust_health(amount, direction):
	check_state()
	if direction == "up":
		GameManager.health += amount
	else:
		GameManager.health -= amount
		GameManager.playSFX(load("res://Menu/assests/Sound Effects/hurt.wav"))
		$AnimatedSprite2D.play("hurt")
	if GameManager.health <= 0:
		killPlayer()

func killPlayer():
	position = %RespawnPoint.position
	$AnimatedSprite2D.flip_h = false
	GameManager.health = 3
	
func check_state():
	var ind = $"%P_State_Machine".current_state
	if ind.is_in_group("Attack"):
		return true
	
func _on_death_area_body_entered(body: Node2D) -> void:
	killPlayer()
