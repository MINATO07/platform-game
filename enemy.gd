extends KinematicBody2D
onready var player= get_tree().get_root().get_child(0).get_node("player")
var motion=Vector2()
const up=Vector2(0,-1)
var start=false

func _ready():
	
	pass

func _process(delta):
	if start==true:
		motion.x=player.global_position.x-global_position.x
		motion.y=player.global_position.y-global_position.y
		move_and_slide(motion,up)
	

func _set_start():
	start=true