extends Enemy



var speed = 250
var skirm_speed = 150
export var health = 200
onready var player = get_node("/root/TestMap/TestPlayer")
var damage = rand_range(25, 40)

export var sight_range = 350
export var attack_range = 250
export var skirm_range = 100

	
#Controls the states for AI Behavior. Do not delete, you dunce.
enum {
	PATROLLING
	PURSUING
	SKIRMISHING
	ATTACKING
	FLEEING
}



var state = PATROLLING

func _physics_process(_delta):
	var distance = position.distance_to(player.global_position)
	var direction = position.direction_to(player.global_position)
	var enemypos = position
	

	match state:
		PATROLLING:
			if (distance <= sight_range):
				state = PURSUING
			else:
				if (health <= 50):
					state = FLEEING
		PURSUING:
			velocity = move_and_slide(speed * direction)
			if (distance <= attack_range):
				state = ATTACKING
			else:
				if (distance >= sight_range):
					state = PATROLLING
				elif (health < 50):
					state = FLEEING
		SKIRMISHING:
			velocity =  move_and_slide(skirm_speed * -direction)
			if (distance >= skirm_range):
				state = ATTACKING
			else:
				if (distance >= sight_range):
					state = PATROLLING
				elif (health < 50):
					state = FLEEING
		ATTACKING:
			velocity = move_and_slide(speed * direction * 0)
			if (health < 50):
				state = FLEEING
			elif (distance <= skirm_range):
				state = SKIRMISHING
				
			else:
				if (distance >= attack_range):
					state = PURSUING
		FLEEING:
			pass
			
			

	
	
func take_damage():
	health = health - damage
	position.x = position.x + 10
	if health <= 0:
		on_die()
		
		
func on_die():
	get_node("AnimatedSprite").visible = false
	get_node("Area2D/CollisionShape2D").disabled = true
