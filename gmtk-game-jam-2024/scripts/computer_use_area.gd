class_name ComputerUseArea
extends Area2D

@onready var progress_bar = %ProgressBar

var computer_id: int = -1


func _get_computer_id() -> int:
	return computer_id


func _update_progress(percentage: float):
	progress_bar.value = clamp(progress_bar.value + percentage, 0.0, 100.0)
