extends Node2D

var leftSilo: Node2D
var middleSilo: Node2D
var rightSilo: Node2D

var time_alive: float = 0

func reload(num_rockets: int):
	leftSilo.reload()
	middleSilo.reload()
	rightSilo.reload()

func _ready():
	leftSilo = get_node("LeftSilo")
	middleSilo = get_node("MiddleSilo")
	rightSilo = get_node("RightSilo")
	get_node("/root/MainScene/GameWindow/GameManager").waveStart.connect(reload)

func mouse_world_position_from_vec2(mouse_position_screen: Vector2):
	var cam: Camera2D = get_node("/root/MainScene/GameWindow/Camera2D")
	if cam == null:
		return Vector2(0,0)
	if cam.get_viewport() == null:
		return Vector2(0,0)
	var screen_bounds = cam.get_viewport().get_visible_rect().size
	var screen_center = cam.get_viewport().get_camera_2d().get_screen_center_position()
	var xLeft = screen_center.x - (screen_bounds.x/2)
	var yTop = screen_center.y - (screen_bounds.y/2)
	return Vector2(xLeft, yTop) + mouse_position_screen

func mouse_world_position():
	return mouse_world_position_from_vec2(get_viewport().get_mouse_position())

func get_closest_armed_silo(target_position: Vector2):
	# Initialize values
	var silos = []
	var closest_distance: float = 1000000
	var closest_silo: Node2D = null
	
	# Only look at silos that have ammunition
	for s in [leftSilo, middleSilo, rightSilo]:
		if s.has_ammo():
			silos.append(s)
			
	# Find the closest silo to the mouse position
	for s in silos:
		var dist = s.global_position.distance_to(target_position)
		if dist < closest_distance:
			closest_distance = dist
			closest_silo = s
			
	return closest_silo

func _process(delta):
	time_alive += delta
	if(time_alive < .5):
		return
	if Input.is_action_just_pressed("Click"):
		var closestSilo = get_closest_armed_silo(mouse_world_position())
		if(closestSilo == null):
			return
		closestSilo.fire(mouse_world_position())
