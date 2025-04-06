extends State
class_name PlayerIdle

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("idle")
	pass

func Update(_delta: float):
	if (Input.get_axis("left","right")):
		state_transition.emit(self, "run")
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "jump")
	
	if Input.is_action_just_pressed("attack"):
		state_transition.emit(self, "attack")

func Exit():
	pass

func Physics_Update(delta: float):
	pass
