extends Area2D
class_name Meteor2
var pmeteoreffect1 := preload("res://meteor/meteor_effect_1.tscn")

var minspeed :float = 250
var maxspeed :float = 300
var minrotationRate :float =20
var maxrotationRate :float =150

var speed : float = 0
var rotationRate :float =0
var life: int = 10

func _ready():
	speed = randi_range(minspeed,maxspeed)
	rotationRate = randi_range(minrotationRate,maxrotationRate)
	
func damage(amount : int):
	life -= amount
	if life<=0:
		var effect1 := pmeteoreffect1.instantiate()
		effect1.position = position
		get_parent().add_child(effect1)
		Signals.emit_signal("on_score_increment",50)
		queue_free()

func _physics_process(delta):
	
	rotation_degrees += rotationRate*delta
	
	
	position.y += speed *delta
	
func _on_area_entered(area):
	if area is player:
		area.damage_1(1)
		var effect1 := pmeteoreffect1.instantiate()
		effect1.position = position
		get_parent().add_child(effect1)
		Signals.emit_signal("on_score_increment",-50)
		queue_free()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
