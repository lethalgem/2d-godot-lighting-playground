class_name EngineerFollowCamera
extends Camera2D

@export var follow_character: CharacterBody2D

func _ready() -> void:
	global_position = follow_character.global_position

	# Attach to character
	var remote_transform := RemoteTransform2D.new()
	remote_transform.remote_path = get_path()
	follow_character.add_child(remote_transform)
