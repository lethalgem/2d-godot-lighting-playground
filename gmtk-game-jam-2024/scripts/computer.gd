@tool
class_name Computer
extends Node2D

@export var sprite: sprite_name
@onready var animated_sprite: AnimatedSprite2D = %ComputerSprite
@onready var computer_use_area: Area2D = %ComputerUseArea
@onready var progress_bar = %ProgressBar

var computer_id: int:
	set(value):
		computer_use_area.computer_id = value
		computer_id = value

enum sprite_name {
	dark_side,
	dark_front,
	white_side,
	white_front,
}


func _ready() -> void:
	if not Engine.is_editor_hint():
		animate()


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		animate()


func animate():
	match sprite:
		sprite_name.dark_side:
			animated_sprite.play("dark_side")
		sprite_name.dark_front:
			animated_sprite.play("dark_front")
		sprite_name.white_side:
			animated_sprite.play("white_side")
		sprite_name.white_front:
			animated_sprite.play("white_front")


func computer_needs_to_be_repaired():
	computer_use_area.should_flash_bar = true


func computer_repaired():
	computer_use_area.should_flash_bar = true
	await get_tree().create_timer(1).timeout
	computer_use_area.hide_progress_bar()
	computer_use_area.reset_progress()
