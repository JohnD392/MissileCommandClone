extends Control

const gameScene = preload("res://Prefabs/game_window.tscn")

func resize():
	set_size(get_viewport_rect().size)


# Called when the node enters the scene tree for the first time.
func _ready():
	resize()


func _on_start_gui_input(event):
	if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
		print("clicked start!")
		var game = gameScene.instantiate()
		get_parent().add_child(game)
		hide()

func _on_settings_gui_input(event):
	if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
		print("Clicked settings!")

func _on_quit_gui_input(event):
	if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
		get_tree().quit(0)
