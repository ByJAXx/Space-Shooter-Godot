extends Node

var score :int = 0

@onready var gos = $UILayer/GameOverScreen
@onready var palyer = $palyer

# var score = hud.score

func _ready():

	Signals.connect("on_score_increment",on_score_increment)
	palyer.killed.connect(_on_player_kill)
	
func _on_player_kill():
	await get_tree().create_timer(0.5).timeout
	gos.visible = true
	gos.set_score(score)

func on_score_increment(amount:int):
	score += amount
