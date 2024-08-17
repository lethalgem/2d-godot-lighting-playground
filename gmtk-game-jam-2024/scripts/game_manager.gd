extends Node2D

@onready var players := {
	"ship":
	{
		viewport = $HBoxContainer/SubViewportContainer2/SubViewport,
		camera = $HBoxContainer/SubViewportContainer2/SubViewport/Camera2D,
		player = $HBoxContainer/SubViewportContainer2/SubViewport/Piloting/Spaceship,
	},
	"engineer":
	{
		viewport = $HBoxContainer/SubViewportContainer/SubViewport,
		camera = $HBoxContainer/SubViewportContainer/SubViewport,
		player = $HBoxContainer/SubViewportContainer2/SubViewport/Piloting/Spaceship/Repair,
	}
}


func _ready():
	# assign the ship's level view to the split screen
	players["engineer"].viewport.world_2d = players["ship"].viewport.world_2d
	# assign splitscreen camera to the engineer
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
