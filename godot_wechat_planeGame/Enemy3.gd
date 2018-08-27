extends KinematicBody2D

var life = 10
var shooting_time = 1
var lifeState
var ALIVE = 1
var DEAD = 0
var isPlayed = false
var speed = 40
var velocity = Vector2()
var score
var isBombed
var boom_animation_finished
var boom_audio_finished

func _ready():
	boom_animation_finished = false
	boom_audio_finished = false
	lifeState = ALIVE
	velocity = Vector2(0, speed)
	$AnimatedSprite.animation = "shoot"
	pass

func _process(delta):
	isBombed = get_parent().get_node("UI/Bomb/isBombed").text
	if isBombed == "true":
		life = 0
	if lifeState == ALIVE:
		shooting_time -= delta
		if shooting_time <= 0:
			var ebullet = preload("res://EBullet.tscn").instance()
			ebullet.position = $EBullet/EBulletPosition.global_position
			ebullet.add_collision_exception_with(self) 
			get_parent().add_child(ebullet)
			shooting_time = 1
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit_by_enemy_3"):
			collision.collider.hit_by_enemy_3()
	if life == 0 and not isPlayed:
		score = int(get_parent().get_node("UI/Score/Count").text)
		score += 100
		get_parent().get_node("UI/Score/Count").text = str(score)
		lifeState = DEAD
		$AnimatedSprite.play("boom")
		$Boom.play()
		isPlayed = true
		$Shape.disabled = true
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
	if lifeState == ALIVE:
		if $AnimatedSprite.animation == "hit":
			$AnimatedSprite.play("shoot")
	if lifeState == DEAD:
		if $AnimatedSprite.animation == "boom":
			boom_animation_finished = true
			visible = false
			
	pass


func _on_Boom_finished():
	boom_audio_finished = true
	pass
