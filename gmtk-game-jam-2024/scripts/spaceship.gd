class_name Spaceship extends CharacterBody2D

@export var ship_body_sprite: AnimatedSprite2D
@export var engine_glow_sprite: AnimatedSprite2D

# dictionary with animation names
var animations := {default = "default", shield = "shield", death = "death"}
var current_animation = animations.shield

# Speed of the movement
var speed = 0
# Speed of the rotation in degrees per second
var rotation_speed = 90.0

var MAX_SPEED = 500
var MIN_SPEED = -50


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("velocity: " + str(velocity))

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
	move_and_slide()
	animate_engine_glow()
	animate_ship_body()
	pass


func animate_ship_body():
	match current_animation:
		animations.default:
			ship_body_sprite.visible = true
			engine_glow_sprite.visible = true
			ship_body_sprite.play(animations.default)
		animations.shield:
			ship_body_sprite.visible = true
			engine_glow_sprite.visible = true
			ship_body_sprite.play(animations.shield)
		animations.death:
			ship_body_sprite.visible = true
			engine_glow_sprite.visible = false
			ship_body_sprite.play(animations.death)
			# should free the child here most likely
		_:
			print("unknown animation for ship body")


func animate_engine_glow():
	if velocity.length() > 0:
		engine_glow_sprite.play()
		engine_glow_sprite.speed_scale = clamp(velocity.length() * 0.008, 0.005, 2)
	else:
		engine_glow_sprite.stop()
