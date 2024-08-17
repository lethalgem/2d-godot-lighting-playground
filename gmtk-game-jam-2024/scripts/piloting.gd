class_name Piloting
extends Node2D

@export var spaceship: CharacterBody2D
@export var transparent_Spaceship: CharacterBody2D
@export var asteroid: CharacterBody2D
@export var repair: Node2D

var MAX_RENDER_DISTANCE = 1000


func _process(delta: float) -> void:
	transparent_Spaceship.global_position = spaceship.global_position
	manageAsteroids()


func manageAsteroids():
	var astroidDistanceFromPlayer = spaceship.position.distance_to(asteroid.position)
	if astroidDistanceFromPlayer > MAX_RENDER_DISTANCE:
		remove_child(asteroid)
