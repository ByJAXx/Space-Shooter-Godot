extends Area2D
class_name player 
var plbullet := preload("res://bullet/bullet.tscn")
signal killed

@onready var sprite := $Sprite2D
@onready var firingpositions := $firingpositions


var speed :float = 300
var life: int=3


var vel := Vector2(0,0)
func _ready():
	Signals.emit_signal("on_player_lfe_changed", life)
		
func _process(delta):
	#animacion
	if vel.x < 0:
		sprite.frame = 0
	elif vel.x > 0:
		sprite.frame =2
	else:
		sprite.frame = 1
	#disparar
	if Input.is_action_just_pressed("shoot"):
		for child in firingpositions.get_children():
			var bullet := plbullet.instantiate()
			bullet.global_position= child.global_position
			get_tree().current_scene.add_child(bullet)
func _physics_process(_delta):
	var dirVec := Vector2(0,0)
	
	if Input.is_action_pressed("move_up"):
		dirVec.y=-1
	if Input.is_action_pressed("muve_down"):
		dirVec.y=1
	if Input.is_action_pressed("move_left"):
		dirVec.x=-1
	if Input.is_action_pressed("move_right"):
		dirVec.x=1
	vel =dirVec.normalized() *speed
	position += vel *_delta
	
	#para no salirse de la pnatalla
	var viewRec = get_viewport_rect()
	position.x = clamp(position.x,0,viewRec.size.x)
	position.y = clamp(position.y,0,viewRec.size.y)
	
func damage_1(amount: int):
	life -= amount
	Signals.emit_signal("on_player_lfe_changed", life)
	if life <=0:
		killed.emit()
		queue_free()
