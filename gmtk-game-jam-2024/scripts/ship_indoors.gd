class_name ShipIndoors
extends Node2D

@onready var doors := {
	"right" = %"Right Door",
	"left" = %"Left Door",
	"top" = %"Top Door",
	"bottom" = %"Bottom Door"
}

func _ready() -> void:
	for door in doors.values():
		disable_door(door)

func enable_door(door: TileMapLayer):
	door.visible = true
	door.collision_enabled = true
	pass


func disable_door(door: TileMapLayer):
	door.visible = false
	door.collision_enabled = false
	pass
