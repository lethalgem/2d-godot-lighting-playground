class_name Repair
extends Node2D

@export var engineer: Engineer

var is_touching_computer: bool = false
var touching_computer: ComputerUseArea = null
var computer_progress_speed: int = 50


func _process(delta: float) -> void:
	if is_touching_computer and Input.is_action_pressed("interact_with_computer"):
		touching_computer._update_progress(delta * computer_progress_speed)


func _on_computer_detection_area_area_entered(area: Area2D) -> void:
	if area is ComputerUseArea:
		set_next_to_computer(true, area)


func _on_computer_detection_area_area_exited(area: Area2D) -> void:
	if area is ComputerUseArea:
		set_next_to_computer(false, area)


func get_computer_name(id: int) -> String:
	return ShipIndoors.computers.keys()[id]


func set_next_to_computer(is_touching: bool, area: ComputerUseArea):
	is_touching_computer = is_touching
	if is_touching:
		touching_computer = area
		print("touching computer " + get_computer_name(area._get_computer_id()))
	else:
		touching_computer = null
		print("no longer touching computer " + get_computer_name(area._get_computer_id()))
