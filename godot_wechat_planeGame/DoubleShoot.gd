extends KinematicBody2D

var speed = 200
var velocity = Vector2()

func _ready():
	velocity = Vector2(0, speed)
	pass

func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("get_double_shoot"):
			collision.collider.get_double_shoot()
			$Get.play()
			$Shape.disabled = true
			visible = false
	pass



func _on_Get_finished():
	queue_free()
	pass
