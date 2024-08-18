class_name GameManager
extends Node2D

@onready var players := {
	"ship":
	{
		viewport = %LeftSplitscreenViewport,
		camera = %LeftSplitscreenCamera2D,
		player = %Piloting.spaceship,
	},
	"zoomed_ship":
	{
		viewport = %RightSplitscreenViewport,
		camera = %RightSplitscreenCamera2D,
		player = %Piloting.spaceship,
		remote_transform = null
	},
	"engineer":
	{
		viewport = %RightSplitscreenOverlaySubViewport,
		camera = %RightSplitscreenOverlayCamera2D,
		player = %Repair.engineer
	}
}

@onready var test_position: ColorRect = %Test_Position


func _ready():
	# assign the ship's level view to the split screen
	players["zoomed_ship"].viewport.world_2d = players["ship"].viewport.world_2d

	# assign splitscreen camera to follow the zoomed_ship and engineer
	for node in players.values():
		if node != players["zoomed_ship"]:
			var remote_transform := RemoteTransform2D.new()
			remote_transform.remote_path = node.camera.get_path()
			node.player.add_child(remote_transform)

	#if node == players["zoomed_ship"]:
	## offset zoomed_ship camera to match starting point for engineer
	#players["zoomed_ship"].remote_transform = remote_transform
	#var engineer_position = players["engineer"].player.position
	## 24.5 works at camera zoom level of 49
	#players["zoomed_ship"].remote_transform.position += engineer_position / 24.5

	# offset zoomed_ship camera to match the location of the engineer
	print(players["zoomed_ship"].camera.global_position)
	print(players["engineer"].camera.global_position)


func _process(delta: float) -> void:
	# pin camera to origin of ship and rotate with it
	players["zoomed_ship"].camera.global_position = (players["zoomed_ship"].player.global_position)
	players["zoomed_ship"].camera.rotation = players["zoomed_ship"].player.rotation

	var engineer_position = players["engineer"].player.position
	#print(players["engineer"].player.rotation)
	#players["engineer"].camera.rotation = players["zoomed_ship"].player.rotation

	#print(players["zoomed_ship"].player.angle_to(players["engineer"].player))
	#print(players["zoomed_ship"].camera.global_position)
	#print(players["zoomed_ship"].player.global_position + engineer_position / 24.5)  # original position of player
	#print(players["engineer"].player.global_position)

# ---

	#var engineer_position_relative_to_ship = (
	#players["zoomed_ship"].player.global_position + (engineer_position / 24.5)
	#)
#
	#test_position.global_position = engineer_position_relative_to_ship
#
	#print(engineer_position_relative_to_ship - players["zoomed_ship"].player.global_position)
#
	#var angle_from_ship_to_engineer = players["zoomed_ship"].player.global_position.angle_to_point(
	#engineer_position_relative_to_ship
	#)
#
	#print(angle_from_ship_to_engineer)
#
	#var distance_from_ship_to_engineer = players["zoomed_ship"].player.global_position.distance_to(
	#engineer_position_relative_to_ship
	#)
#
	#print(distance_from_ship_to_engineer)
#
	#var rotated_point = rotated_point(
	#players["zoomed_ship"].player.global_position,
	#angle_from_ship_to_engineer,
	#distance_from_ship_to_engineer
	#)
	#print(rotated_point)
#
	#test_position.global_position = rotated_point

# ---

	#players["zoomed_ship"].camera.origin = players["zoomed_ship"].player.origin

	#players["zoomed_ship"].camera.position += engineer_position / 24.5

	# try
	# get angle and distance for engineer relative to 0,0 in repair, aka angle and distance just for the repair scene
	# distance will have to be multiplied by a scalar of some sort but who cares?
	# use that to place the square -- but how? with rotated_point?

	var engineer = players["engineer"].player
	var engineer_relative_position = engineer.position
	#print(engineer_relative_position)

	var relative_angle = Vector2(0, 0).angle_to_point(engineer_relative_position)
	var relative_distance = Vector2(0, 0).distance_to(engineer_relative_position)
	#print(relative_angle)
	print(relative_distance)

	var spaceship: Spaceship = players["zoomed_ship"].player
	#print(spaceship.rotation_degrees)
	var combined_angle = relative_angle - deg_to_rad(spaceship.rotation_degrees)
	#print(combined_angle)
	var new_point_location = rotated_point(
		spaceship.global_position, combined_angle, relative_distance
	)
	#print(new_point_location)

	test_position.global_position = new_point_location
	test_position.rotation = spaceship.rotation

	pass


func rotated_point(_center, _angle, _distance):
	return _center + Vector2(sin(_angle), cos(_angle)) * _distance
