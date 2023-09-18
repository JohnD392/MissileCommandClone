#silo.gd
extends Node2D

signal ammo_amount_changed(new_amount: int)

var samPrefab = preload("res://Prefabs/Sam.tscn")
var proximityToExplode = 20
var speed = 200
var current_ammo: int = 12
var max_ammo: int = 12
var velocity: Vector2 = Vector2.ZERO

func has_ammo():
	if current_ammo > 0: 
		return true
	return false

func fire(target_position: Vector2):
	if(current_ammo) <= 0:
		return
	current_ammo -= 1 # decrement how much ammo we have
	ammo_amount_changed.emit(current_ammo)
	var sam = samPrefab.instantiate()
	add_child(sam)
	sam.set_target(target_position)
	sam.global_position = global_position
	var directionToTarget = target_position - sam.global_position
	sam.rotation = directionToTarget.angle() + PI/2
	sam.set_direction(directionToTarget)

func reload():
	current_ammo = max_ammo
	ammo_amount_changed.emit(current_ammo)

func _process_physics(delta):
	position += velocity * delta
