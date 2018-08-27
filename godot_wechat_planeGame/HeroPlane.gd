extends KinematicBody2D

var fly = false
var shooting_time = 0.3
var lifeState
var ALIVE = 1
var DEAD = 0
var isPlayed = false
var get_double = false
var bomb_count = 0

func _ready():
	lifeState = ALIVE
	pass


func _process(delta):
	if lifeState == ALIVE:
		shooting_time -= delta
		if fly:
			position = get_global_mouse_position()
			if position.x < 0:
				position.x = 0
			if position.x > 640:
				position.x = 640
			if position.y > 1130:
				position.y = 1130
			if position.y < 0:
				position.y = 0
		if shooting_time <= 0:
			if not get_double:
				var bullet = preload("res://Bullet.tscn").instance()
				bullet.position = $Bullet/BulletPosition.global_position
				bullet.add_collision_exception_with(self) 
				get_parent().add_child(bullet)
			else:
				var left_bullet = preload("res://Bullet.tscn").instance()
				var right_bullet = preload("res://Bullet.tscn").instance()
				left_bullet.position = $Bullet/DoubleShootLeft.global_position
				right_bullet.position = $Bullet/DoubleShootRight.global_position
				left_bullet.add_collision_exception_with(self)
				right_bullet.add_collision_exception_with(self)
				get_parent().add_child(left_bullet)
				get_parent().add_child(right_bullet)
			$Bullet/Shoot.play()
			shooting_time = 0.3
	elif lifeState == DEAD:
		if not isPlayed:
			$GameOver.play()
			$Shape.disabled = true
			isPlayed = true
	pass


func _on_TextureButton_button_down():
	fly = true
	pass


func _on_TextureButton_button_up():
	fly = false
	pass


func hit_by_enemy_1():
	$AnimatedSprite.animation = "boom"
	lifeState = DEAD
	pass


func hit_by_enemy_2():
	$AnimatedSprite.animation = "boom"
	lifeState = DEAD
	pass


func hit_by_enemy_3():
	$AnimatedSprite.animation = "boom"
	lifeState = DEAD
	pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "boom":
		var current_score = int(get_parent().get_node("UI/Score/Count").text)
		var game_over_scene = preload("res://GameOver.tscn").instance()
		get_parent().add_child(game_over_scene)
		get_parent().get_node("GameOver/UI/CurrentScore/Count").text = str(current_score)
	pass


func hit_by_ebullet():
	$AnimatedSprite.animation = "boom"
	lifeState = DEAD
	pass


func get_double_shoot():
	get_double = true
	$Bullet/DoubleShootLastTime.start()
	pass


func get_bomb():
	bomb_count = int(get_parent().get_node("UI/Bomb/Count").text)
	bomb_count += 1
	get_parent().get_node("UI/Bomb/Count").text = str(bomb_count)
	pass


func _on_DoubleShootLastTime_timeout():
	get_double = false
	pass
