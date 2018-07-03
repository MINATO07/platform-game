extends KinematicBody2D
onready var player= get_tree().get_root().get_child(0).get_node("player")
var motion=Vector2()
const up=Vector2(0,-1)
var start=false
var random
const base=600

func _ready():
	random=rand_range(1,10)
	pass

func _physics_process(delta):
	
	if start==true:
		if random>=5:
			motion.x=player.global_position.x-global_position.x
			motion.y=player.global_position.y-global_position.y
			if global_position.x>=player.global_position.x:
				$Sprite.flip_h=true
			else :
				$Sprite.flip_h=false
			move_and_slide(motion,up)
			$Sprite.play("fly")
		else:
			motion.x=player.global_position.x-global_position.x
			if !is_on_floor():
				motion.y=motion.y+10
			if global_position.x>=player.global_position.x:
				$Sprite.flip_h=true
			else :
				$Sprite.flip_h=false
			move_and_slide(motion,up)
			$Sprite.play("crawl")
	

func _set_start():
	if random<5:
		global_position.y=base
	start=true