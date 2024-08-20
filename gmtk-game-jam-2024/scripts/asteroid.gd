extends CharacterBody2D

# Speed of the movement
var speed = 75

var direction = RandomNumberGenerator.new().randf_range(0, 2 * PI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("velocity: " + str(velocity))

	# Move forward in the direction the node is facing
	velocity = Vector2.from_angle(direction) * speed


func _physics_process(delta: float) -> void:
	move_and_slide()
	pass
