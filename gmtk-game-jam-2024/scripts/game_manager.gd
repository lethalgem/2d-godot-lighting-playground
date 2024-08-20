class_name GameManager
extends Node2D


var bussing = preload("res://assets/voice_lines/bussing.mp3")
var incoming = preload("res://assets/voice_lines/incoming_drones.mp3")
var lost = preload("res://assets/voice_lines/lost_computer.mp3")

@onready var VoiceLinePlayer : AudioStreamPlayer = %VoiceLinePlayer
@onready var level_label: Label = %LevelLabel
@onready var dialogue_box: DialogueBox = %DialogueBox
@onready var players := {
	"ship":
	{
		viewport = %LeftSplitscreenViewport,
		camera = %LeftSplitscreenCamera2D,
		player = %Piloting.spaceship,
		parallax_background = %Piloting.left_splitscreen_background
	},
	"zoomed_ship":
	{
		viewport = %RightSplitscreenViewport,
		camera = %RightSplitscreenCamera2D,
		player = %Piloting.spaceship,
		parallax_background = %Piloting.right_splitscreen_background
	},
	"engineer":
	{
		viewport = %RightSplitscreenOverlaySubViewport,
		camera = %RightSplitscreenOverlayCamera2D,
		player = %Repair.engineer
	}
}

var tutorials_enabled = true

func _ready():
	# assign the ship's level view to the split screen
	players["zoomed_ship"].viewport.world_2d = players["ship"].viewport.world_2d
	players["ship"].parallax_background.custom_viewport = (players["ship"].viewport)
	players["zoomed_ship"].parallax_background.custom_viewport = (players["zoomed_ship"].viewport)

	# assign splitscreen camera to follow the zoomed_ship and engineer
	for node in players.values():
		if node != players["zoomed_ship"]:
			var remote_transform := RemoteTransform2D.new()
			remote_transform.remote_path = node.camera.get_path()
			node.player.add_child(remote_transform)

	show_controls_tutorial()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_tutorial"):
		tutorials_enabled = !tutorials_enabled
		dialogue_box.visible = tutorials_enabled

func _process(delta: float) -> void:
	# pin camera to engineer as they walk around
	var engineer = players["engineer"].player
	var engineer_relative_position = engineer.position

	var relative_angle = Vector2(0, 0).angle_to_point(engineer_relative_position)
	var relative_distance = Vector2(0, 0).distance_to(engineer_relative_position) * 0.04

	var spaceship: Spaceship = players["zoomed_ship"].player
	var combined_angle = deg_to_rad(90) - relative_angle - deg_to_rad(spaceship.rotation_degrees)

	var new_point_location = rotated_point(
		spaceship.global_position, combined_angle, relative_distance
	)

	var zoomed_camera = players["zoomed_ship"].camera
	zoomed_camera.global_position = new_point_location
	zoomed_camera.rotation = spaceship.rotation


func rotated_point(_center, _angle, _distance):
	return _center + Vector2(sin(_angle), cos(_angle)) * _distance


func show_controls_tutorial():
	if tutorials_enabled:
		VoiceLinePlayer.stream = incoming
		VoiceLinePlayer.play()

		dialogue_box.set_text("Pilot: Find the busted COMPUTER and those shields back up now! We've got incoming DRONES!

	WASD: Move spaceship
	ARROWS: Move engineer
	SPACE or ENTER: Repair Computer
	H: Toggle tutorials off
	", 8)


func _on_piloting_shields_down() -> void:
	if tutorials_enabled:
		VoiceLinePlayer.stream = lost
		VoiceLinePlayer.play()
		
		dialogue_box.set_text("Pilot: We lost another COMPUTER! Get those shields back online now!
	
	
		H: Toggle tutorials off", 5)


func _on_repair_computer_repaired() -> void:
	if tutorials_enabled:
		VoiceLinePlayer.stream = bussing
		VoiceLinePlayer.play()

		dialogue_box.set_text("Pilot: Bussin! Now RAM those DRONES while the shields are up!


	H: Toggle tutorials off", 5)


func _on_piloting_level_changed(number: int) -> void:
	level_label.text = "Level: " + str(number)
