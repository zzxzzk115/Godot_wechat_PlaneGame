extends Node

var score

func _ready():
	score = 0
	Input.set_custom_mouse_cursor(null)
	pass


func _on_bgm_finished():
	$bgm.play()
	pass


func _on_PauseButton_pressed():
	get_tree().change_scene("res://MainScene.tscn")
	pass
