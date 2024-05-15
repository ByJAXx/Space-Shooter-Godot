extends Area2D

var pBullet := preload("res://bullet/bullet_ef.tscn")

var speed: float = 650

func _physics_process(delta):
	position.y -= speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.has_method("damage"):
		var bulleffect:=pBullet.instantiate()
		bulleffect.position = position 
		get_parent().add_child(bulleffect)
		area.damage(2)
		queue_free()
		
