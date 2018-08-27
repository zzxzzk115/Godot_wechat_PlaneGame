extends Node


func _on_Start_pressed():
	get_tree().change_scene("res://PlayingState.tscn")
	pass


func _on_Exit_pressed():
	get_tree().quit()
	pass
