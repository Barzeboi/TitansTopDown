extends "res://Enemy.gd"

var speed = 300


func _physics_process(_delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)
	

func _on_Area2D_body_entered(_body):
	player = _body
		


func _on_Area2D_body_exited(_body):
	player = null
