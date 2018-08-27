extends TextureRect


func _on_BackToMain_pressed():
	get_tree().change_scene("res://MainScene.tscn")
	pass


func _on_Restart_pressed():
	get_tree().change_scene("res://PlayingState.tscn")
	pass
