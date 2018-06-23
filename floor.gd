extends Node2D
onready var player= get_tree().get_root().get_child(0).get_node("player")
signal destroy

func _ready():

	pass

func _process(delta):
	if get_node("bottom_pos").global_position.x+640 <= player.global_position.x:
		queue_free()
		emit_signal("destroy")
	pass