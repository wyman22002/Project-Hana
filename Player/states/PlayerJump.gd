extends State
class_name PlayerJump

@export var player: CharacterBody2D
@export var sprite : AnimatedSprite2D
@export var jump_velocity = -350
@export var speed = 200

func Enter():
	GameManager.playSFX(load("res://Menu/assests/Sound Effects/jump.wav"))
	sprite.play("jump")
	jump()

func Exit():
	pass

func Update(_delta: float):
	if (Input.get_axis("left","right")) and player.is_on_floor():
		state_transition.emit(self, "run")
	if player.is_on_floor():
		state_transition.emit(self, "idle")

func Physics_Update(delta: float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = jump_velocity
	
	if player.velocity.y < 0:
		sprite.play("jump")
	if player.velocity.y > 0:
		sprite.play("fall")

	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

func jump():
	player.velocity.y = jump_velocity
