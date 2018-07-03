extends Node2D
onready var player= get_tree().get_root().get_child(0).get_node("player")

func _ready():

	pass

func _physics_process(delta):
	if get_node("bottom_pos").global_position.x+1280 <= player.global_position.x:
		queue_free()
	pass

