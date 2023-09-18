extends Line2D

@export_category('Trail')
@export var length : = 10

@onready var parent : Node2D = get_parent()
var offset : = Vector2.ZERO

func _ready() -> void:
	top_level = true

func _physics_process(_delta: float) -> void:
	global_position = Vector2.ZERO
	
	# set offset of trail to rocket
	var angle = get_parent().rotation - PI/2
	var direction = Vector2(cos(angle), sin(angle))
	offset = direction * -14

	var point : = parent.global_position + offset
	add_point(point, 0)
	
	if get_point_count() > length:
		remove_point(get_point_count() - 1)

