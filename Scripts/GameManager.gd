## This class manages the main game logic relating to the score, round, etc.
extends Node

signal waveStart(numRockets: int) # Used to signal that the wave is starting
signal intro # Show introduction
signal onGameStart # Used to signal that the game is starting
signal onGameEnd # Used to signal that the player has lost

var rocketsToSpawn = 10
var round = 1
var score = 0

func _ready():
	intro.emit()

func _on_missile_spawner_missile_spawning_complete():
	while(!missiles_gone()):
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(5).timeout
	rocketsToSpawn += 5
	waveStart.emit(rocketsToSpawn)

func missiles_gone() -> bool:
	var num_missiles = get_node("../MissileSpawner").get_children().size()
	print("Num missiles: ", num_missiles)
	if num_missiles > 0:
		return false
	return true
