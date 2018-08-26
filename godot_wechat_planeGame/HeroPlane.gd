extends KinematicBody2D

var fly = false
var shooting_time = 0.3
var lifeState
var ALIVE = 1
var DEAD = 0
var isPlayed = false


func _ready():
	lifeState = ALIVE
	pass


func _process(delta):
	if lifeState == ALIVE:
		shooting_time -= delta
		if fly:
			position = get_global_mouse_position()
		if shooting_time <= 0:
			var bullet = preload("res://Bullet.tscn").instance()
			bullet.position = $Bullet/BulletPosition.global_position
			bullet.add_collision_exception_with(self) 
			get_parent().add_child(bullet)
			$Bullet/Shoot.play()
			shooting_time = 0.3
	elif lifeState == DEAD:
		if not isPlayed:
			$GameOver.play()
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


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "boom":
		get_tree().change_scene("res://MainScene.tscn")
	pass
