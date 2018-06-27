extends KinematicBody2D
var motion=Vector2()
onready var timer=get_node("Timer")
const fire=preload("res://projectile.tscn")
const up=Vector2(0,-1)
const gravity=20
var speed=200
var run="run"
var air_action="jump"
const jump_height=-600
const acc=25

func _ready():
	timer.start()

func _physics_process(delta):
	var friction=false
	motion.y+=gravity
	if(is_on_floor()):
		if(Input.is_action_pressed("ui_up")):
			motion.y=jump_height
			air_action="jump"
		elif Input.is_action_pressed("flip"):
			motion.y=jump_height
			air_action="flip"
		if(Input.is_action_pressed("ui_right")):
			if(motion.x<=speed):
				motion.x+=acc
			else:
				motion.x=speed
			$Sprite.flip_h=false
			$Sprite.play(run)
		elif(Input.is_action_pressed("ui_left")):
			if(motion.x>=-speed):
				motion.x-=acc
			$Sprite.flip_h=true
			$Sprite.play(run)
		else:
			friction=true
			$Sprite.play("idle")
		if(friction==true):
			motion.x=lerp(motion.x,0,0.2)
	else:
		if(Input.is_action_pressed("ui_right")):
			if(motion.x<=speed):
				motion.x+=acc
			else:
				motion.x=speed
			$Sprite.flip_h=false
		elif(Input.is_action_pressed("ui_left")):
			if(motion.x>=-speed):
				motion.x-=acc
			$Sprite.flip_h=true
		if air_action=="jump":
			if(motion.y<0):
				$Sprite.play("jump")
			else :
				$Sprite.play("fall")
			if(friction==true):
				motion.x=lerp(motion.x,0,0.03)
		elif air_action=="flip":
			if(motion.y<0):
				$Sprite.play("front_flip")
			else:
				$Sprite.play("front_flip_end")
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

func set_speed(var new_speed,var new_run):
	speed=new_speed
	run=new_run
	pass

func restart_timer():
	timer.set_wait_time(0.5)
	timer.start()


func _on_power_timer_timeout():
	run="run"
	speed=200
	pass # replace with function body
