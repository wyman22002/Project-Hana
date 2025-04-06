extends State
class_name PlayerRun

@export var player: CharacterBody2D
@export var sprite : AnimatedSprite2D
@export var speed = 200

func Enter():
	sprite.play("run")

func Exit():
	pass

func Update(_delta: float):
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "jump")
		
	if not (Input.get_axis("left","right")):
		state_transition.emit(self, "idle")
		
	if Input.is_action_just_pressed("attack"):
		state_transition.emit(self, "attack")

func Physics_Update(delta: float):

	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
