class_name Spaceship extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Speed of the movement
var speed = 50.0
# Speed of the rotation in degrees per second
var rotation_speed = 90.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move forward in the direction the node is facing
	var velocity = Vector2.UP.rotated(rotation)
	position += velocity * speed * delta

	# Modify speed while moving forward automatically
	if Input.is_action_pressed("move_up") && speed < 200:
		speed += 1
	elif Input.is_action_pressed("move_down") && speed > 0:
		speed -= 1

	# change roatation
	if Input.is_action_pressed("move_left"):
		rotation -= rotation_speed * deg_to_rad(delta)
	elif Input.is_action_pressed("move_right"):
		rotation += rotation_speed * deg_to_rad(delta)
