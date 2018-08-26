extends KinematicBody2D

var life = 2
var lifestate
var ALIVE = 1
var DEAD = 0
var isPlayed = false
var score
var speed = 100
var velocity = Vector2()


func _ready():
	lifestate = ALIVE
	velocity = Vector2(0, speed)
	pass


func _process(delta):
	if position.y >= 1130:
		queue_free()
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit_by_enemy_1"):
			collision.collider.hit_by_enemy_1()
	if life == 0 and not isPlayed:
		lifestate = DEAD
		$AnimatedSprite.play("boom")
		$Boom.play()
		isPlayed = true
	pass


func hit_by_bullet():
	life -= 1
	pass


func _on_AnimatedSprite_animation_finished():
	if lifestate == DEAD:
		$Boom.play()
		queue_free()
		score = int(get_parent().get_node("UI/Score/Count").text)
		score += 10
		get_parent().get_node("UI/Score/Count").text = str(score)
	pass
