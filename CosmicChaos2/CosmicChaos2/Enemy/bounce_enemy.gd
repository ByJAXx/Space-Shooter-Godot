extends Enemy

@export var HorizontalSpeed := 50

var horizontaldirection :int = 1

func _physics_process(delta):
	position.y += verticalSpeed*delta
	position.x +=HorizontalSpeed *delta
	
	var viewRect := get_viewport_rect()
	if position.x < viewRect.position.x or position.x>viewRect.end.x:
		HorizontalSpeed *=-1

