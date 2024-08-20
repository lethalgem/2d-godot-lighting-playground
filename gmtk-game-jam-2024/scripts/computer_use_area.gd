class_name ComputerUseArea
extends Area2D

@onready var progress_bar = %ProgressBar

var computer_id: int = -1
var should_flash_bar = false
var flashing_time = 0
var flash_reset_time = 0.25  # seconds


func _get_computer_id() -> int:
	return computer_id


func show_progress_bar():
	should_flash_bar = true


func hide_progress_bar():
	should_flash_bar = false
	progress_bar.visible = false


func _update_progress(percentage: float) -> float:
	progress_bar.visible = true
	should_flash_bar = false
	progress_bar.value = clamp(progress_bar.value + percentage, 0.0, 100.0)
	return progress_bar.value


func reset_progress():
	progress_bar.value = false


func _process(delta: float) -> void:
	if should_flash_bar:
		flashing_time += delta
		if flashing_time >= flash_reset_time:
			progress_bar.visible = !progress_bar.visible
			flashing_time = 0
