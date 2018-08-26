extends KinematicBody2D

var speed = -500
var velocity = Vector2()


func _ready():
	velocity = Vector2(0, speed)
	pass


func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
		if collision.collider.has_method("hit_by_bullet"):
			collision.collider.hit_by_bullet()
	if position.y <= 0:
		queue_free()
	pass


