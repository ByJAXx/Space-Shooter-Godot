extends Node2D

const MIN_SPAWN_TIME =0.25

var plEnemies := [preload("res://Enemy/bounce_enemy.tscn"),preload("res://Enemy/enemy.tscn"),preload("res://Enemy/fastenemy.tscn"),preload("res://Enemy/nave.tscn")]
@onready var spawntimer := $spawntime
var plMeteor1 := preload("res://meteor/meteor.tscn")
var plMeteor2 := preload("res://meteor/meteor_2.tscn")

var nextspawntime :float= 0.80

func _ready():
	randomize()
	spawntimer.start(nextspawntime)


func _on_spawntime_timeout():
	
	var viewRect :=get_viewport_rect()
	var xPos :=randi_range(viewRect.position.x,viewRect.end.x)
	
	if randf()< 0.10:
		var meteor1 : Meteor1 = plMeteor1.instantiate()
		meteor1.position =Vector2(xPos,position.y)
		get_tree().current_scene.add_child(meteor1)
		var meteor2 :Meteor2 = plMeteor2.instantiate()
		meteor2.position =Vector2(xPos,position.y)
		get_tree().current_scene.add_child(meteor2)
	else:	
		#enemigo aparece
		
		var enemypreload = plEnemies[randi()%plEnemies.size()]
		var enemy : Enemy = enemypreload.instantiate() 
		enemy.position= Vector2(xPos,position.y)
		get_tree().current_scene.add_child(enemy)
	
	#reinicio del timer
	nextspawntime-= 0.0025
	if nextspawntime<MIN_SPAWN_TIME:
		nextspawntime=MIN_SPAWN_TIME
	spawntimer.start(nextspawntime)
