extends KinematicBody2D

var vector = Vector2.ZERO
var speed = 850


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta



func _on_Timer_timeout():
	get_node("Sprite").visible = false
	get_node("CollisionShape2D").disabled = true




func _on_Bullet_area_shape_entered(area_id, area, area_shape, local_shape):
	queue_free()
