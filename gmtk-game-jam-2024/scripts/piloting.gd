class_name Piloting
extends Node2D

@export var spaceship: CharacterBody2D
@export var transparent_Spaceship: CharacterBody2D
@export var repair: Node2D


func _process(delta: float) -> void:
	transparent_Spaceship.global_position = spaceship.global_position
