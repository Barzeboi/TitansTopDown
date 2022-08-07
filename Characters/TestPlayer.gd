extends KinematicBody2D

const speed : int = 350
var fire_rate = 9
var Bullet = preload("res://Weapons/Bullet.tscn")
onready var update_delta = 1.0 / fire_rate
var current_time : float = 0.0
onready var _animated_sprite = $AnimatedSprite
var last_direction = Vector2.ZERO

func _physics_process(_delta):
	

	var input_vector = Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	input_vector = input_vector.normalized()
	move_and_slide(speed * input_vector)
	
	
	if input_vector.length_squared() > 0:
		# Store the direction for use later when needing
		# to choose the idle animation
		
		# Diagonal movement
		if input_vector.x != 0 and input_vector.y != 0:
			
			last_direction = input_vector
			
			if input_vector.y > 0:
				if input_vector.x > 0:
					_animated_sprite.play("run_down_right")
				else:
					_animated_sprite.play("run_down_left")
			else:
				if input_vector.x > 0:
					_animated_sprite.play("run_up_right")
				else:
					_animated_sprite.play("run_up_left")
		# Otherwise we are moving either horizontal or vertical, so its just a
		# matter of finding out which.
		# horizontal movement
		elif input_vector.x != 0:
			if input_vector.x > 0:
				_animated_sprite.play("run_right")
			else:
				_animated_sprite.play("run_left")
		# vertical movement
		else:
			if input_vector.y > 0:
				_animated_sprite.play("run_down")
			else:
				_animated_sprite.play("run_up")
	
	else:
		
		if last_direction.x != 0 and last_direction.y != 0:
			if last_direction.y > 0:
				if last_direction.x > 0:
					_animated_sprite.play("idle_down_right")
				else:
					_animated_sprite.play("idle_down_left")
					
			else:
				if last_direction.x > 0:
					_animated_sprite.play("idle_up_right")
				else:
					_animated_sprite.play("idle_up_left")
					
		elif last_direction.x != 0:
			if last_direction.x > 0:
				_animated_sprite.play("idle_left")
			else:
				_animated_sprite.play("idle_right")
				
		else:
			if last_direction.y > 0:
				_animated_sprite.play("idle_down")
			else:
				_animated_sprite.play("idle_up")


func _process(_delta: float) -> void:
	current_time += _delta
	if (current_time < update_delta):
		return
		
	if Input.is_action_pressed("shoot"):
		current_time = 0.0
		shoot()
		
func shoot():
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = $Gun/Position2D.global_transform
