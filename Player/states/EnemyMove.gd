extends State
class_name EnemyMove

@export var enemy: CharacterBody2D
#@export var tile: TileMapLayer
@export var SPEED: int = 50
@export var ACCELERATION: int = 300
@export var sprite: AnimatedSprite2D
@export var ray_cast_down: RayCast2D
@export var ray_cast_out: RayCast2D
var direction: Vector2
#var right_bounds: Vector2
#var left_bounds: Vector2
var in_air = false
var in_wall = false

func Enter():
	pass

func Exit():
	pass
	
func handle_movement(delta: float) -> void:
	enemy.velocity = enemy.velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	enemy.move_and_slide()
	
func change_direction() -> void:
	# look for ledge
	if not ray_cast_down.is_colliding() and in_air == false:
		# turn around. priority
		in_air = true
		if direction.x == 1:
			direction = Vector2(-1, 0)
			sprite.scale.x = 1
		else:
			direction = Vector2(1, 0)
			sprite.scale.x = -1
		return
	
	if ray_cast_down.is_colliding() and in_air == true:
		in_air = false
		
	# look for walls
	if ray_cast_out.is_colliding() and in_wall == false:
		var collider = ray_cast_out.get_collider()
		if not collider.is_in_group("Player"):
			#var collision_point = tile.local_to_map(ray_cast_out.get_collision_point())
			#var titleAtlas = tile.get_cell_atlas_coords(collision_point)
			"""
			const notAWall: Array = [
				Vector2i(19, 1),
				Vector2i(20, 1),
				Vector2i(19, 2),
				Vector2i(20, 2),
				Vector2i(22, 1),
				Vector2i(23, 1),
				Vector2i(22, 2),
				Vector2i(23, 1)
			]
			"""
			#if titleAtlas in notAWall:
			#	return
			in_wall = true
			# turn around
			if direction.x == 1:
				direction = Vector2(-1, 0)
				sprite.scale.x = 1
			else:
				direction = Vector2(1, 0)
				sprite.scale.x = -1
			return
	if not ray_cast_out.is_colliding() and in_wall == true:
		in_wall = false
		
	if direction.x == 1:
		# moving right
		if enemy.position.x >= enemy.right_bounds.x:
			# flip to moving left
			direction = Vector2(-1, 0)
			sprite.scale.x = 1
				
	elif direction.x == -1:
		# moving left
		if enemy.position.x <= enemy.left_bounds.x:
			# flip to moving right
			direction = Vector2(1, 0)
			sprite.scale.x = -1
	else:
		# move left by default
		direction = Vector2(1, 0)
		sprite.scale.x = -1

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	handle_movement(delta)
	change_direction()
