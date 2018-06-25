extends Area2D
onready var player= get_tree().get_root().get_child(0).get_node("player")
onready var power_timer= get_tree().get_root().get_child(0).get_node("power_timer")


func _ready():
	pass



func _process(delta):
	
	
	pass


func _on_power_up_body_entered(body):
	#print(body.get_instance_id())
	if body.get_instance_id()==1061:
		player.set_speed(400)
		power_timer.start()
		queue_free()
	pass # replace with function body
