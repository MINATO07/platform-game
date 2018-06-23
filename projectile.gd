extends Area2D
const SPEED=700
const enemy=preload("res://enemy.tscn")
var can_move=false
var direction=Vector2(0,0)
func _ready():
	pass

func _process(delta):
	if can_move:
		global_position=global_position+direction*(SPEED*delta)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass 

func _set_direction():
	can_move=true
	direction=get_global_mouse_position()-global_position
	direction=direction/direction.length()
	


func _on_projectile_body_entered(body):
	if can_move:
		if body.get_parent().get_instance_id()==1055:
			body.queue_free()
		print(body.get_parent().get_instance_id())
		queue_free()
	pass