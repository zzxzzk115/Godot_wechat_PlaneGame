extends Node


func _on_Timer_timeout():
	var enemy1 = preload("res://Enemy1.tscn").instance()
	enemy1.position.x = rand_range(30, 610)
	enemy1.position.y = 0
	get_parent().add_child(enemy1)
	pass


func _on_Timer2_timeout():
	var enemy2 = preload("res://Enemy2.tscn").instance()
	enemy2.position.x = rand_range(50, 590)
	enemy2.position.y = 0
	get_parent().add_child(enemy2)
	pass


func _on_Timer3_timeout():
	var enemy3 = preload("res://Enemy3.tscn").instance()
	enemy3.position.x = rand_range(120, 480)
	enemy3.position.y = 0
	get_parent().add_child(enemy3)
	pass
