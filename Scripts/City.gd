extends Area2D

signal onCityDeath

func free_node(node: Node):
	node.queue_free()

func disable():
	hide()

func enable():
	show()

func _on_area_entered(area):
	if(area.name.contains("Missile") and is_visible_in_tree()):
		disable()
		onCityDeath.emit()
		call_deferred("free_node", area)
		area.create_deferred_explosion()
