class_name Flashlight
extends Node2D

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())


func _on_engineer_changed_direction_to(direction: Engineer.Direction) -> void:
	match direction:
		Engineer.Direction.Up:
			position = Vector2(10, 5)
		Engineer.Direction.Down:
			position = Vector2(-10, 5)
		Engineer.Direction.Left:
			position = Vector2(5, 10)
		Engineer.Direction.Right:
			position = Vector2(-5, 10)
