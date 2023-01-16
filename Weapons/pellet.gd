extends Area2D

var vector = Vector2.ZERO
var speed = 850

enum{
	PISTOL
	SMG
	SG
	MG
	RPG
}


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta



func _on_Timer_timeout():
	get_node("Sprite").visible = false
	get_node("CollisionShape2D").disabled = true


func _on_bullet_body_entered(body):
	if body.is_in_group("Enemies"):
		body.damage
	queue_free()
	
