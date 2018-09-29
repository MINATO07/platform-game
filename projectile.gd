extends Area2D
const SPEED=1000
const enemy=preload("res://enemy.tscn")
onready var root= get_tree().get_root().get_child(0)
var can_move=false
func _ready():
	pass

func _process(delta):
	if can_move:
		#global_position=global_position+direction*(SPEED*delta)
		move_local_x(SPEED*delta)
		
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass 

func _set_direction():
	global_rotation=global_rotation+get_angle_to(get_global_mouse_position())
	can_move=true



func _on_projectile_body_entered(body):
	#print(body.get_parent().get_instance_id())
	if can_move:
		if body.get_parent().get_instance_id()==root.get_instance_id():
			body.score_update()
			body.queue_free()
		queue_free()
	pass