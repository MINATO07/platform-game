extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	
	global_rotation=global_rotation+get_angle_to(get_global_mouse_position())+deg2rad(90)
	print(global_rotation)
	pass
