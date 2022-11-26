extends KinematicBody2D

const speed : int = 350
var fire_rate = 9
var SMG = preload ("res://Weapons/SMG.tscn")
var bullet = preload("res://Weapons/pellet.tscn")
onready var update_delta = 1.0 / fire_rate
var current_time : float = 0.0
onready var _animated_sprite = $AnimatedSprite
var last_direction = Vector2.ZERO
enum{
	NO_GUN
	WITH_GUN
}

var state = NO_GUN


func _physics_process(_delta):
	

	if PickUp():
		state = WITH_GUN
	
	
	var input_vector = Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	var _input_vector = input_vector.normalized()
	move_and_slide(speed * _input_vector)
			
			
	match state:
		NO_GUN:
			if _input_vector.length_squared() > 0:
			# Store the direction for use later when needing
			# to choose the idle animation
			
			# Diagonal movement
				if _input_vector.x != 0 and _input_vector.y != 0:
					
					last_direction = _input_vector
					
					if _input_vector.y > 0:
						if _input_vector.x > 0:
							_animated_sprite.play("run_down_right")
						else:
							_animated_sprite.play("run_down_left")
					else:
						if _input_vector.x > 0:
							_animated_sprite.play("run_up_right")
						else:
							_animated_sprite.play("run_up_left")
				# Otherwise we are moving either horizontal or vertical, so its just a
				# matter of finding out which.
				# horizontal movement
				elif _input_vector.x != 0:
					if _input_vector.x > 0:
						_animated_sprite.play("run_right")
					else:
						_animated_sprite.play("run_left")
				# vertical movement
				else:
					if _input_vector.y > 0:
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
		
func PickUp():
	pass
		
func shoot():
	var b = bullet.instance()
	owner.add_child(b)
	b.transform = $Pivot/Position2D.global_transform
