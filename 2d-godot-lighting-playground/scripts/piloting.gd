class_name Piloting
extends Node2D

@export var spaceship: Spaceship
@export var asteroid: CharacterBody2D
@export var left_splitscreen_background: ParallaxBackground
@export var right_splitscreen_background: ParallaxBackground
@export var shields_up_time: float = 5.0  # seconds

signal shields_down
signal level_changed(number: int)

var drone_scene = preload("res://scenes/drones.tscn")
var drones: Array = []
var MAX_RENDER_DISTANCE = 3000

var level = 1:
	set(value):
		level_changed.emit(value)
		level


func _ready() -> void:
	var instance: Drone = drone_scene.instantiate()
	add_child(instance)
	instance.global_position.x = spaceship.global_position.x + 500
	instance.global_position.y = spaceship.global_position.y + 500

	instance.target = spaceship.global_position
	instance.speed = 100
	drones.append(instance)


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
	var astroidDistanceFromPlayer = spaceship.global_position.distance_to(asteroid.global_position)
	if astroidDistanceFromPlayer > MAX_RENDER_DISTANCE:
		asteroid.global_position.x = spaceship.global_position.x + generate_rand_distance(500, 501)
		asteroid.global_position.y = spaceship.global_position.y + generate_rand_distance(500, 501)


func generate_rand_distance(min: int, max: int) -> int:
	var rand = RandomNumberGenerator.new()

	var my_array = [1, -1]
	var weights = PackedFloat32Array([1, 1])

	return rand.randf_range(min, max) * my_array[rand.rand_weighted(weights)]


func spawn_drone():
	level += 1
	for i in range(level):
		var instance: Drone = drone_scene.instantiate()
		add_child(instance)
		instance.global_position.x = spaceship.global_position.x + generate_rand_distance(400, 2000)
		instance.global_position.y = spaceship.global_position.y + generate_rand_distance(400, 2000)

		instance.target = spaceship.global_position
		instance.speed = RandomNumberGenerator.new().randf_range(250, 480)
		drones.append(instance)


func _on_repair_computer_repaired() -> void:
	spaceship.bring_shields_online()
	await get_tree().create_timer(shields_up_time).timeout
	spaceship.take_shields_offline()
	shields_down.emit()
