extends State
class_name PlayerAttack

@export var player: CharacterBody2D
@export var sprite : AnimatedSprite2D
@export var speed = 225


func Enter():
	GameManager.playSFX(load("res://Menu/assests/Sound Effects/powerUp.wav"))
	sprite.play("roll")
	$AttackTimer.start()
	
func Exit():
	pass

func Update(_delta: float):
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "jump")

func Physics_Update(delta: float):
	# there needs be be a timer of sort for how long the
	# attack lasts before active become true
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

func _on_attack_timer_timeout() -> void:
	if not (Input.get_axis("left","right")):
		state_transition.emit(self, "idle")

	if (Input.get_axis("left","right")):
		state_transition.emit(self, "run")
