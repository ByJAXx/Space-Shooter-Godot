extends Control

var score :int = 0

func _ready():
	Signals.connect("on_score_increment",on_score_increment)
	
func _on_button_pressed():
	get_tree().reload_current_scene()

func set_score(value):
	$Panel/Score.text = "Score: "+str(score)

func on_score_increment(amount:int):
	score += amount

