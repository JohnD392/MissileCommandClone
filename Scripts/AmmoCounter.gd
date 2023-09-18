extends RichTextLabel

func _on_left_silo_ammo_amount_changed(new_amount: int):
	text = "[center] " + str(new_amount)


func _on_middle_silo_ammo_amount_changed(new_amount: int):
	text = "[center] " + str(new_amount)


func _on_right_silo_ammo_amount_changed(new_amount):
	text = "[center] " + str(new_amount)
