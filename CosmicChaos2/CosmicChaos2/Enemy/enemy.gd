extends Area2D
class_name Enemy

@export var verticalSpeed := 150
@export var health :int = 30

var plEnemydie := preload("res://Enemy/enemy_die.tscn")

func _physics_process(delta):
	position.y += verticalSpeed*delta

func damage(amount : int ):
	health -= amount
	if health <=0:
		var effect1 := plEnemydie.instantiate()
		effect1.global_position = global_position
		get_parent().add_child(effect1)
		
		Signals.emit_signal("on_score_increment",100)
		
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is player:
		area.damage_1(1)
		var effect1 := plEnemydie.instantiate()
		effect1.global_position = global_position
		get_parent().add_child(effect1)
		Signals.emit_signal("on_score_increment",-50) 
		queue_free()
