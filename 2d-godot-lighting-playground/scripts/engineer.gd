class_name Engineer
extends CharacterBody2D

signal changed_direction_to(direction: Direction)

@export var sprite: AnimatedSprite2D
@export var speed: int = 250

@onready var current_direction = Direction.Down
@onready var current_state = state.Idle

enum Direction {
	Up,
	Down,
	Left,
	Right,
}

enum state {
	Idle,
	Walk,
}


func _ready() -> void:
	try_animate()


func _process(delta: float) -> void:
	var vector_to_point = get_global_mouse_position() - global_position
	var deg = rad_to_deg(vector_to_point.angle())

	if deg > -45 && deg <= 45:
		change_direction_to(Direction.Right)
	elif deg >= 45 && deg < 135:
		change_direction_to(Direction.Down)
	elif deg >= 135 || deg < -135:
		change_direction_to(Direction.Left)
	else:
		change_direction_to(Direction.Up)

func change_direction_to(direction: Direction):
	if direction != current_direction:
		current_direction = direction
		changed_direction_to.emit(direction)


func _physics_process(delta: float):
	get_input()
	move_and_slide()
	update_state()
	try_animate()


func get_input():
	var input_direction = Input.get_vector(
		"engineer_move_left", "engineer_move_right", "engineer_move_up", "engineer_move_down"
	)
	velocity = input_direction * speed

func update_state():
	if velocity == Vector2(0, 0):
		current_state = state.Idle
	else:
		current_state = state.Walk


func try_animate():
		var animation_name = (
			state.keys()[current_state] + " " + Direction.keys()[current_direction]
		)
		if animation_name != sprite.get_animation():
			sprite.play(animation_name)
