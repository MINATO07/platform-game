extends KinematicBody2D
onready var player= get_tree().get_root().get_child(0).get_node("player")
onready var ui= get_tree().get_root().get_child(0).get_node("ui")
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
			motion.x=(player.global_position.x-global_position.x)/2
			if !is_on_floor():
				motion.y=motion.y+10
			if global_position.x>=player.global_position.x:
				$Sprite.flip_h=true
			else :
				$Sprite.flip_h=false
			move_and_slide(motion,up)
			$Sprite.play("crawl")
			if global_position.y>=1400:
				queue_free()
		
		#enemy collision
		if  get_slide_count()!=0:
			var collide_info=get_slide_collision(0)
			if collide_info!=null and collide_info.collider_id==player.get_instance_id() :
				if player.get_node("Player_Anime").get_current_animation()=="sword" or player.get_node("Player_Anime").get_current_animation()=="sword_back" or player.get_node("Player_Anime").get_current_animation()=="kick":
					score_update()
					$blast.visible=true
					var t = Timer.new()
					t.set_wait_time(0.5)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					queue_free()
				player.decrease_health()

func _set_start():
	if random<5:
		global_position.y=base
	start=true

func score_update():
	player.score+=10
	ui.get_node("score_label").text=str(player.score)