extends KinematicBody2D

var speed = 300
var velocity = Vector2()

func _ready():
	velocity = Vector2(0, speed)
	pass

func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
		if collision.collider.has_method("hit_by_ebullet"):
			collision.collider.hit_by_ebullet()
	if position.y >= 1130:
		queue_free()
	pass


func hit_by_bullet():
	queue_free()
	pass
