extends KinematicBody2D

var life = 6
var lifestate
var ALIVE = 1
var DEAD = 0
var isPlayed = false
var score
var speed = 80
var velocity = Vector2()
var isBombed
var boom_animation_finished
var boom_audio_finished

func _ready():
	boom_animation_finished = false
	boom_audio_finished = false
	lifestate = ALIVE
	$AnimatedSprite.animation = "default"
	velocity = Vector2(0, speed)
	pass


func _process(delta):
	isBombed = get_parent().get_node("UI/Bomb/isBombed").text
	if isBombed == "true":
		life = 0
	if position.y >= 1130:
		queue_free()
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit_by_enemy_2"):
			collision.collider.hit_by_enemy_2()
	if life == 0 and not isPlayed:
		$Shape.disabled = true
		score = int(get_parent().get_node("UI/Score/Count").text)
		score += 50
		get_parent().get_node("UI/Score/Count").text = str(score)
		lifestate = DEAD
		$AnimatedSprite.play("boom")
		$Boom.play()
		isPlayed = true
	if boom_animation_finished and boom_audio_finished:
		queue_free()
		get_parent().get_node("UI/Bomb/isBombed").text = "false"
		boom_animation_finished = false
		boom_audio_finished = false
	pass


func hit_by_bullet():
	life -= 1
	if life > 0:
		$AnimatedSprite.play("hit")
	pass


func _on_AnimatedSprite_animation_finished():
	if lifestate == ALIVE:
		if $AnimatedSprite.animation == "hit":
			$AnimatedSprite.play("default")
	if lifestate == DEAD:
		if $AnimatedSprite.animation == "boom":
			boom_animation_finished = true
			visible = false
			
	pass


func _on_Boom_finished():
	boom_audio_finished = true
	pass
