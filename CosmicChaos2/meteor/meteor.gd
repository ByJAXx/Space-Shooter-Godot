extends Area2D
class_name Meteor1
var pMeteorEffect := preload("res://meteor/meteor_effect.tscn")

var minspeed :float = 100
var maxspeed :float = 150
var minrotationRate :float =20
var maxrotationRate :float =150

var speed : float = 0
var rotationRate :float =0
var life: int = 100
func _ready():
	speed = randi_range(minspeed,maxspeed)
	rotationRate = randi_range(minrotationRate,maxrotationRate)
	
func damage(amount : int):
	life -= amount
	if life<=0:
		var effect := pMeteorEffect.instantiate()
		effect.position = position
		get_parent().add_child(effect)
		Signals.emit_signal("on_score_increment",1000)
		queue_free()

func _physics_process(delta):
	
	rotation_degrees += rotationRate*delta
	
	
	position.y += speed *delta
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is player:
		area.damage_1(1)
		var effect := pMeteorEffect.instantiate()
		effect.position = position
		get_parent().add_child(effect) 
		Signals.emit_signal("on_score_increment",-100)
		queue_free()
