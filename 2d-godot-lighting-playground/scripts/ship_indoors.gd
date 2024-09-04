class_name ShipIndoors
extends Node2D

@onready var med_computer: Computer = %Med_Computer
@onready var cargo_computer: Computer = %Cargo_Computer
@onready var area01_computer: Computer = %Area01_Computer
@onready var area02_computer: Computer = %Area02_Computer

@onready var doors := {
	"right" = %"Right Door",
	"left" = %"Left Door",
	"top" = %"Top Door",
	"bottom" = %"Bottom Door"
}

enum computers {
	med,
	cargo,
	area01,
	area02,
}

func _ready() -> void:
	for door in doors.values():
		disable_door(door)
	assign_computer_ids()

func enable_door(door: TileMapLayer):
	door.visible = true
	door.collision_enabled = true
	pass


func disable_door(door: TileMapLayer):
	door.visible = false
	door.collision_enabled = false
	pass

func get_computer_with_id(id: computers) -> Computer:
	match id:
		computers.med:
			return med_computer
		computers.cargo:
			return cargo_computer
		computers.area01:
			return area01_computer
		computers.area02:
			return area02_computer
		_:
			print("unknown id provided, giving default computer")
			return med_computer

func assign_computer_ids():
	med_computer.computer_id = computers.med
	cargo_computer.computer_id = computers.cargo
	area01_computer.computer_id = computers.area01
	area02_computer.computer_id = computers.area02
