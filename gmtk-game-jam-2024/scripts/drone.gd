class_name Drone
extends Node2D

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("animating to")
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move_to_point(point: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", point, 10)


func animate_death():
	sprite.play("death")
	await sprite.animation_finished
	print("freeing")
	queue_free()


func animate(point: Vector2):
	var vector_to_point = point - position
	print(vector_to_point)
	var deg = rad_to_deg(vector_to_point.angle())
	print(deg)

	if deg > -45 && deg <= 45:
		sprite.play("walk_right")
	elif deg >= 45 && deg < 135:
		sprite.play("walk_up")
	elif deg >= 135 && deg > -135:
		sprite.play("walk_left")
	else:
		sprite.play("walk_down")
