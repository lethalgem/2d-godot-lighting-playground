extends CharacterBody2D

# Speed of the movement
var speed = 50
# Speed of the rotation in degrees per second
var rotation_speed = 90.0

var MAX_SPEED = 500
var MIN_SPEED = -50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("velocity: " + str(velocity))

	# Move forward in the direction the node is facing
	velocity = Vector2.UP.rotated(rotation) * speed


func _physics_process(delta: float) -> void:
	move_and_slide()
	pass
