extends Node

signal missileSpawningStart
signal missileSpawningComplete

var scene = preload("res://Prefabs/Missile.tscn")

var currentState: BaseState
var missileSpawnConfig: MissileSpawnConfig

var s = "Intro"

var timeSinceShot = 0

var duration = 18

func random_position():
	var cam: Camera2D = get_node("/root/MainScene/GameWindow/Camera2D")
	var screen_bounds = cam.get_viewport().get_visible_rect().size
	var screen_center = cam.get_viewport().get_camera_2d().get_screen_center_position()
	var xLeft = screen_center.x - (screen_bounds.x/2)
	var xRight = screen_center.x + (screen_bounds.x/2)
	var x_position = randi_range(xLeft, xRight)
	var y_position = screen_center.y - (screen_bounds.y/2)
	return Vector2(x_position, y_position)

func spawn_rocket():
	var instance = scene.instantiate()
	add_child(instance)
	instance.name = "Missile"
	instance.position = random_position()
	instance.set_direction_toward_bottom()

func _ready():
	missileSpawnConfig = MissileSpawnConfig.new()
	missileSpawnConfig.init(10, 10)
	await get_tree().create_timer(3).timeout
	rocket_salvo()

func rocket_salvo():
	while missileSpawnConfig._currentCount < missileSpawnConfig._count:
		spawn_rocket() # spawn a rocket into the scene
		missileSpawnConfig._currentCount += 1 # increment how many rockets we've fired
		timeSinceShot = 0 # Reset the shot timer
		await get_tree().create_timer(missileSpawnConfig.timePerBurst()).timeout
	missileSpawningComplete.emit()

func _on_game_manager_wave_start(numRockets):
	missileSpawnConfig = MissileSpawnConfig.new()
	missileSpawnConfig.init(numRockets, duration)
	rocket_salvo()
