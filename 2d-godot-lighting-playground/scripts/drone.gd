class_name Drone extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

var target: Vector2
var speed = 50

var isDying = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animate_death()
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(target)
	velocity = direction * speed
	move_and_slide()
	animate(target)


func animate_death():
	sprite.play("death")
	await sprite.animation_finished
	queue_free()


func animate(point: Vector2):
	if isDying:
		return

	var vector_to_point = point - global_position
	var deg = rad_to_deg(vector_to_point.angle())

	if deg > -45 && deg <= 45:
		sprite.play("walk_right")
	elif deg >= 45 && deg < 135:
		sprite.play("walk_down")
	elif deg >= 135 || deg < -135:
		sprite.play("walk_left")
	else:
		sprite.play("walk_up")


func _on_area_2d_area_entered(area: Area2D) -> void:
	isDying = true
	animate_death()
