extends Node


func _on_Timer_timeout():
	var enemy1 = preload("res://Enemy1.tscn").instance()
	enemy1.position.x = rand_range(30, 610)
	enemy1.position.y = 0
	get_parent().add_child(enemy1)
	pass # replace with function body
