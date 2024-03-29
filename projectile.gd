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
		if body.get_parent().get_instance_id()==root.get_instance_id() and body.hit==false:
			body.hit=true
			body.score_update()
			body.get_node("blast").visible=true
			can_move=false
			var t = Timer.new()
			t.set_wait_time(0.5)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			if body!=null:
				body.queue_free()
				body=null
		queue_free()
	pass