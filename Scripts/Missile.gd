extends Node2D

class_name Missile

@export var speed: float = 69
var direction: Vector2 = Vector2.DOWN

var explosionPrefab = preload("res://Prefabs/explosion.tscn")

var is_dead: bool = false

func set_direction_toward_bottom():
	var cam: Camera2D = get_node("/root/MainScene/GameWindow/Camera2D")
	var screen_bounds = cam.get_viewport().get_visible_rect().size
	var screen_center = cam.get_viewport().get_camera_2d().get_screen_center_position()
	var xLeft = screen_center.x - (screen_bounds.x/2)
	var xRight = screen_center.x + (screen_bounds.x/2)
	var x_position = randi_range(xLeft, xRight)
	var y_position = screen_center.y + (screen_bounds.y/2)
	direction = (Vector2(x_position, y_position) - position).normalized()
	rotation = direction.angle() + PI/2

func move(delta):
	position += direction * speed * delta

func _physics_process(delta):
	move(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(global_position.y > 400):
		queue_free()

func create_explosion():
	if(is_dead):
		return
	var chain_reaction_explosion = explosionPrefab.instantiate()
	get_tree().root.add_child(chain_reaction_explosion)
	chain_reaction_explosion.global_position = global_position	
	is_dead = true

func create_deferred_explosion():
	call_deferred("create_explosion")
