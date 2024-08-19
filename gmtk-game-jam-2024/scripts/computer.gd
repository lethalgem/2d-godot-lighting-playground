@tool
class_name Computer
extends Node2D

@export var sprite: sprite_name
@onready var animated_sprite: AnimatedSprite2D = %ComputerSprite
@onready var computer_use_area: Area2D = %ComputerUseArea
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
