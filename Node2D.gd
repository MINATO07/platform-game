extends Node2D
onready var root= get_tree().get_root().get_child(0).get_node("temp_floor")
const floor_instance = preload("res://floor.tscn")
const valley_instance = preload("res://valley.tscn")
const hurdle_instance = preload("res://hurdle.tscn")
const width=1280

func _ready():
	spawnground()
	spawnandmove()
	spawnandmove()
	pass

func _process(delta):


	pass
func nextpos():
	var current_pos=Vector2(global_position.x+width,global_position.y)
	global_position=current_pos
func spawnground():
	var r=rand_range(0,10)
	if r>=5:
		var new_floor=floor_instance.instance()
		new_floor.connect("destroy",self,"spawnandmove")
		new_floor.position.y=global_position.y
		new_floor.position.x=global_position.x
		root.add_child(new_floor)
		var new_hurdle=hurdle_instance.instance()
		var x=rand_range(150,500)
		var y=rand_range(150,250)
		new_hurdle.position.x=global_position.x+x
		new_hurdle.position.y=global_position.y+y
		root.add_child(new_hurdle)
	else:
		var new_valley=valley_instance.instance()
		new_valley.connect("destroy_valley",self,"spawnandmove")
		new_valley.position.y=global_position.y
		new_valley.position.x=global_position.x
		root.add_child(new_valley)
	pass
	
func spawnandmove():
	nextpos()
	spawnground()
	pass
	
	