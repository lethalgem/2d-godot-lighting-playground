class_name Spaceship extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Speed of the movement
var speed = 50
# Speed of the rotation in degrees per second
var rotation_speed = 90.0

var MAX_SPEED = 500
var MIN_SPEED = -50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("velocity: " + str(velocity))

	# Move forward in the direction the node is facing
	velocity = Vector2.UP.rotated(rotation) * speed

	# Modify speed while moving forward automatically
	if Input.is_action_pressed("move_up") && speed < MAX_SPEED:
		speed += 1
	elif Input.is_action_pressed("move_down") && speed > MIN_SPEED:
		speed -= 1

	# change roatation
	if Input.is_action_pressed("move_left"):
		rotation -= rotation_speed * deg_to_rad(delta)
	elif Input.is_action_pressed("move_right"):
		rotation += rotation_speed * deg_to_rad(delta)


func _physics_process(delta: float) -> void:
	print(str(move_and_slide()))
	pass
