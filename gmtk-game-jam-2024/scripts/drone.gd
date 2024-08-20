class_name Drone extends Node2D

@onready var sprite: AnimatedBody2D = %AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animate(Vector2(100, 0))
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move_to_point(point: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", point, 1)


func animate_death():
	await sprite.play("death")
	queue_free()


func animate(point: Vector2):
	var vector_to_point = point - position

	var deg = rad_to_deg(vector_to_point.angle())

	if deg > -45 || deg <= 45:
		sprite.play("walk_right")
	elif deg >= 45 && deg < 135:
		sprite.play("walk_down")
	elif deg >= 135 && deg > -135:
		sprite.play("walk_left")
	else:
		sprite.play("walk_down")
