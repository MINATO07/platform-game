extends Node2D

const enemy=preload("res://enemy.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	var enemy_instance=enemy.instance()
	add_child(enemy_instance)
	enemy_instance.global_position.x=(get_node("player").global_position.x)+300
	enemy_instance.global_position.y=(get_node("player").global_position.y)-200
	enemy_instance._set_start()
	pass 
