class_name Flashlight
extends Node2D

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
