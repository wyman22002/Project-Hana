extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Change animations
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	if velocity.x != 0:
		$AnimatedSprite2D.play("run") 
	else:
		$AnimatedSprite2D.play("idle")
		
	if velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	if velocity.y > 0:
		$AnimatedSprite2D.play("fall")
		
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite2D.play("roll")
		var attackNode = load("res://Player/attack.tscn")
		var newAttack = attackNode.instantiate()
		if $AnimatedSprite2D.flip_h == false:
			newAttack.direction = -1
		else:
			newAttack.direction = 1
		newAttack.set_position(%AttackSpawnPoint.global_transform.origin)
		get_parent().add_child(newAttack)

func adjust_health(amount, direction):
	if direction == "up":
		GameManager.health += amount
	else:
		GameManager.health -= amount
		$AnimatedSprite2D.play("hurt")
	if GameManager.health <= 0:
		killPlayer()

func killPlayer():
	position = %RespawnPoint.position
	$AnimatedSprite2D.flip_h = false
	GameManager.health = 3

func _on_death_area_body_entered(body: Node2D) -> void:
	killPlayer()

# To make a jump to kill enemy check if there is downward momentum and if so kill enemey
