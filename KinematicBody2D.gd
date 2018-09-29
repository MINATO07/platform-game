extends KinematicBody2D
var motion=Vector2()
onready var timer=get_node("shooting_timer")
onready var attack_timer=get_node("attack_timer")
onready var gun_spawntime=get_node("gun_spawntime")
const mountain_bg=preload("res://mountain_bg.tscn")
const forest_bg=preload("res://forest_bg.tscn")
const fire=preload("res://projectile.tscn")
const up=Vector2(0,-1)
const gravity=20
var health=100
var speed=400
var run="run"
var dead=false
var air_action="jump"
var shape=PoolVector2Array()
var current_attack="kick"
var bg=ParallaxBackground
var bg_flip=true
const jump_height=-800
const acc=25

func _ready():
	timer.start()
	shape.append(Vector2(-30,6))
	shape.append(Vector2(30,6))
	shape.append(Vector2(30,25))
	shape.append(Vector2(-30,25))
	bg=mountain_bg.instance()
	add_child(bg)

func _physics_process(delta):
	var friction=false
	motion.y+=gravity
	if !dead:
		if(attack_timer.is_stopped()):
			if(is_on_floor()):
				if(Input.is_action_pressed("ui_up")):
					motion.y=jump_height
					air_action="jump"
				elif Input.is_action_pressed("flip"):
					motion.y=jump_height
					air_action="flip"
				
				#attack
				
				if Input.is_action_pressed("kick"):
					current_attack="kick"
					attack_timer.start()
				elif Input.is_action_pressed("sword"):
					current_attack="sword"
					attack_timer.start()
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
		else:
			if current_attack=="sword":
				if !$Player_Anime.is_playing():
					if $Sprite.flip_h==false:
						$Player_Anime.play("sword")
					else:
						$Player_Anime.play("sword_back")
				if $Sprite.flip_h==false:
					motion.x=400
				else:
					motion.x=-400
			elif current_attack=="kick":
				if !$Player_Anime.is_playing():
					$Player_Anime.play("kick")
				if $Sprite.flip_h==false:
					motion.x=400
				else:
					motion.x=-400
				motion.y=-80
		if Input.is_action_pressed("left_click"):
			$Bazooka.visible=true
			gun_spawntime.wait_time=3
			gun_spawntime.start()
			if timer.is_stopped():
				var new_fire=fire.instance()
				get_parent().add_child(new_fire)
				new_fire.global_position=get_node("Bazooka").get_node("Position2D").global_position
				new_fire.scale.x=1.5
				new_fire.scale.y=1.5
				new_fire._set_direction()
				restart_timer()
	motion=move_and_slide(motion,up)
	if Input.is_action_pressed("demo") or health<=0:
		dead=true
		$CollisionShape2D.polygon=shape
		$Sprite.play("death")
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		get_tree().change_scene("rand_world.tscn")
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
	speed=400
	pass

func decrease_health():
	health=health-5
	pass


func _on_bg_timer_timeout():
	if bg_flip==true:
		bg.queue_free()
		bg=forest_bg.instance()
		bg_flip=false
	else:
		bg.queue_free()
		bg=mountain_bg.instance()
		bg_flip=true
	add_child(bg)
	pass # replace with function body


func _on_gun_spawntime_timeout():
	$Bazooka.visible=false
	pass # replace with function body
