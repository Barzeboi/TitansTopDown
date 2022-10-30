extends KinematicBody2D


var velocity = Vector2(0,0)
var speed = 450
export var health = 300
onready var player = get_node("/root/TestMap/TestPlayer")
export var sight_range = 350
export var attack_range = 250


enum {
	PATROLLING
	SKIRMISHING
	ATTACKING
	FLEEING
}

var state = PATROLLING

func _physics_process(_delta):
	var distance = position.distance_to(player.global_position)
	match state:
		PATROLLING:
			if (distance <= sight_range):
				state = SKIRMISHING
			else:
				if (distance >= sight_range):
					state = PATROLLING
				elif (distance >= attack_range):
					state = ATTACKING
				elif (health <= 50):
					state = FLEEING
		SKIRMISHING:
			velocity = (player.position - position).normalized() 
			if (distance <= attack_range):
				state = ATTACKING
			else:
				if (distance >= attack_range):
					state = SKIRMISHING
				elif (distance >= sight_range):
					state = PATROLLING
				elif (health < 50):
					state = FLEEING
		ATTACKING:
			pass
			if (health < 50):
				state = FLEEING
		FLEEING:
			pass
	velocity = move_and_slide(velocity)
	
