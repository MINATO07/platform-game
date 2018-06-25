extends Node2D
const base=250
const enemy=preload("res://enemy.tscn")
const powerup=preload("res://power up.tscn")
onready var spawn_timer=get_node("power_spawn_timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	#print(get_node("player").get_instance_id())
	if int(get_node("player").global_position.x)%2000>=0 and int(get_node("player").global_position.x)%2000<=5 :
		if spawn_timer.is_stopped():
			spawn_timer.start()
			var new_power=powerup.instance()
			add_child(new_power)
			new_power.global_position.y=base
			new_power.global_position.x=get_node("player").global_position.x+500
	pass


func _on_Timer_timeout():
	var enemy_instance=enemy.instance()
	add_child(enemy_instance)
	enemy_instance.global_position.x=(get_node("player").global_position.x)+300
	enemy_instance.global_position.y=(get_node("player").global_position.y)-200
	enemy_instance._set_start()
	pass 
