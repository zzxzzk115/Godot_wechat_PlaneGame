extends Node


func _on_Timer_timeout():
	var double_shoot = preload("res://DoubleShoot.tscn").instance()
	double_shoot.position.x = rand_range(40, 600)
	double_shoot.position.y = 0
	get_parent().add_child(double_shoot)
	pass


func _on_Timer2_timeout():
	var bomb = preload("res://Bomb.tscn").instance()
	bomb.position.x = rand_range(40, 600)
	bomb.position.y = 0
	get_parent().add_child(bomb)
	pass
