extends Area2D

var velocity
var playerObject
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerObject = get_node("../Player").get_node("AnimatedSprite2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Prevent player movement here
	# Player attack animation here
	if direction == 1:
		velocity = Vector2().rotated(rotation_degrees)
	else:
		velocity = Vector2().rotated(rotation_degrees)
	position += velocity

func _on_timer_timeout():
	queue_free()
	# Return player movement here

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		GameManager.score += 200
		area.get_parent().queue_free()
		queue_free()
