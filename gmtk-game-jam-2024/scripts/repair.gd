class_name Repair
extends Node2D

@export var engineer: Engineer


func _on_computer_detection_area_area_entered(area: Area2D) -> void:
	print(area)
	if area is ComputerUseArea:
		var computer_id = area._get_computer_id()
		print(ShipIndoors.computers.keys()[computer_id])
