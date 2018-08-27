extends Node

var score
var bomb_count

func _ready():
	score = 0
	Input.set_custom_mouse_cursor(null)
	pass


func _on_bgm_finished():
	$bgm.play()
	pass


func _on_PauseButton_pressed():
	get_node("UI/Resume").disabled = false
	get_node("UI/Resume").visible = true
	get_tree().paused = true
	pass


func _on_Bomb_pressed():
	bomb_count = int($UI/Bomb/Count.text)
	bomb_count -= 1
	if bomb_count >= 0:
		$UI/Bomb/Count.text = str(bomb_count)
		if bomb_count > 0:
			$UI/Bomb/isBombed.text = "true"
	pass


func _on_Resume_pressed():
	get_tree().paused = false
	get_node("UI/Resume").disabled = true
	get_node("UI/Resume").visible = false
	pass
