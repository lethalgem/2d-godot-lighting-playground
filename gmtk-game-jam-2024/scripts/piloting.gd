class_name Piloting
extends Node2D

@export var spaceship: CharacterBody2D
@export var asteroid: CharacterBody2D
@export var left_splitscreen_background: ParallaxBackground
@export var right_splitscreen_background: ParallaxBackground

var MAX_RENDER_DISTANCE = 1000


func _process(delta: float) -> void:
	manageAsteroids()


func manageAsteroids():
	if asteroid == null:
		return
	var astroidDistanceFromPlayer = spaceship.position.distance_to(asteroid.position)
	if astroidDistanceFromPlayer > MAX_RENDER_DISTANCE:
		asteroid.queue_free()
