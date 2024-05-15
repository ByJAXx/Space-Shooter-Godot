extends Control

var plife := preload("res://HUD/life_icon.tscn")

@onready var lifecontainer := $Lifecontainer
@onready var scorelabel :=$Score

var score :int = 0

func _ready():
	clearlives()
	var hud_script = $"/root/HUD/hud.gd"
	Signals.connect("on_player_lfe_changed",on_player_lfe_changed)
	Signals.connect("on_score_increment",on_score_increment)
	
func clearlives():
	for child in lifecontainer.get_children():
		lifecontainer.remove_child(child)
		child.queue_free()

func setLuves(lives):
	clearlives()
	for i in range(lives):
		lifecontainer.add_child(plife.instantiate())

func on_player_lfe_changed(life: int):
	setLuves(life)
	

func on_score_increment(amount:int):
	score += amount
	scorelabel.text = str(score)
