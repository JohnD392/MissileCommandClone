#explosion.tscn
extends Node2D

signal missileAreaEnteredSignal(area: Area2D)

var maxSize: float = 5
var growthModifier: float = 1.025

var explosionPrefab = preload("res://Prefabs/explosion.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale = scale * growthModifier
	if(scale.x > maxSize):
		growthModifier -= .08
	if scale.x < 0.5:
		queue_free()
		
func create_explosion(_global_position: Vector2):
	var ex = explosionPrefab.instantiate()
	get_tree().root.add_child(ex)
	ex.global_position = _global_position
	pass
	
func free_node(node: Node):
	node.queue_free()

# Triggered when something enters the explosion
func _on_area_entered(area):
	if(area.name.contains("Missile")):
		call_deferred("free_node", area)
		call_deferred("create_explosion", area.global_position)
