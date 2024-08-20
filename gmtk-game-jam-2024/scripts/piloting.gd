class_name Piloting
extends Node2D

@export var spaceship: CharacterBody2D
@export var asteroid: CharacterBody2D
@export var left_splitscreen_background: ParallaxBackground
@export var right_splitscreen_background: ParallaxBackground

var drone_scene = preload("res://scenes/drones.tscn")
var drones: Array = []
var MAX_RENDER_DISTANCE = 1000

var level = 0


func _ready() -> void:
	spawn_drone()


func _process(delta: float) -> void:
	if !drones.size():
		spawn_drone()
	manageAsteroids()


func _physics_process(delta: float) -> void:
	var iterator = 0
	var new_drones = []
	for drone in drones:
		var wr = weakref(drone)
		if wr.get_ref():
			drone.target = spaceship.global_position
			new_drones.append(drone)
	drones = new_drones


func manageAsteroids():
	if asteroid == null:
		return
	var astroidDistanceFromPlayer = spaceship.position.distance_to(asteroid.position)
	if astroidDistanceFromPlayer > MAX_RENDER_DISTANCE:
		asteroid.queue_free()


func spawn_drone():
	level += 1
	for i in range(level):
		var instance: Drone = drone_scene.instantiate()
		add_child(instance)
		instance.global_position.x = (
			spaceship.position.x + RandomNumberGenerator.new().randf_range(125, 450)
		)
		instance.global_position.y = (
			spaceship.position.y - RandomNumberGenerator.new().randf_range(125, 450)
		)
		instance.target = spaceship.global_position
		instance.speed = RandomNumberGenerator.new().randf_range(125, 450)
		drones.append(instance)
