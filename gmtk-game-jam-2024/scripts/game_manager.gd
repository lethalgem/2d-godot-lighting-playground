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
		player = %Piloting.repair.engineer,
	},
	"engineer":
	{
		viewport = %RightSplitscreenOverlaySubViewport,
		camera = %RightSplitscreenOverlayCamera2D,
		player = %Repair.engineer
	}
}


func _ready():
	# assign the ship's level view to the split screen
	players["zoomed_ship"].viewport.world_2d = players["ship"].viewport.world_2d

	# assign splitscreen camera to the engineer
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)

	# offset zoomed_ship camera to match the location of the engineer
	print(players["zoomed_ship"].camera.global_position)
	print(players["engineer"].camera.global_position)
