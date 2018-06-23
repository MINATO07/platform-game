extends KinematicBody2D
var motion=Vector2()
onready var timer=get_node("Timer")
const fire=preload("res://projectile.tscn")
const up=Vector2(0,-1)
const gravity=20
const speed=200
const jump_height=-600
const acc=25

func _ready():
	timer.start()

func _physics_process(delta):
	var friction=false
	motion.y+=gravity
	if(Input.is_action_pressed("ui_right")):
		if(motion.x<=speed):
			motion.x+=acc
		$Sprite.flip_h=false
		$Sprite.play("run")
	elif(Input.is_action_pressed("ui_left")):
		if(motion.x>=-speed):	
			motion.x-=acc
		$Sprite.flip_h=true
		$Sprite.play("run")		
	else:
		$Sprite.play("idle")
		friction=true
	if(is_on_floor()):
		if(Input.is_action_just_pressed("ui_up")):
			motion.y=jump_height
		if(friction==true):
			motion.x=lerp(motion.x,0,0.2)
	else:
		if(motion.y<0):
			$Sprite.play("jump")
		else :
			$Sprite.play("fall")
		if(friction==true):
			motion.x=lerp(motion.x,0,0.03)
	motion=move_and_slide(motion,up)
	if Input.is_action_pressed("left_click"):
		if timer.is_stopped():
			var new_fire=fire.instance()
			get_parent().add_child(new_fire)
			new_fire.global_position=get_node("Position2D").global_position
			new_fire._set_direction()
			restart_timer()
	pass


func restart_timer():
	timer.set_wait_time(0.5)
	timer.start()
