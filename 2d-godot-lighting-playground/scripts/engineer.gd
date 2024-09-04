class_name Engineer
extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var speed: int = 250

@onready var directions_traveled = Array()  # can assume never empty because we push a value on ready
@onready var current_state = state.Idle


func _ready() -> void:
	directions_traveled.push_front(direction.Down)
	sprite.play("Idle Down")


enum direction {
	Up,
	Down,
	Left,
	Right,
}

enum state {
	Idle,
	Walk,
}


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("engineer_move_right"):
		push(directions_traveled, direction.Right)
	elif Input.is_action_just_pressed("engineer_move_left"):
		push(directions_traveled, direction.Left)
	elif Input.is_action_just_pressed("engineer_move_up"):
		push(directions_traveled, direction.Up)
	elif Input.is_action_just_pressed("engineer_move_down"):
		push(directions_traveled, direction.Down)

	if (
		directions_traveled.size() >= 2
		and (
			Input.is_action_pressed("engineer_move_right")
			or Input.is_action_pressed("engineer_move_left")
			or Input.is_action_pressed("engineer_move_up")
			or Input.is_action_pressed("engineer_move_down")
		)
	):
		if (
			Input.is_action_just_released("engineer_move_right")
			and directions_traveled[0] == direction.Right
		):
			pop_front(directions_traveled)
		if (
			Input.is_action_just_released("engineer_move_left")
			and directions_traveled[0] == direction.Left
		):
			pop_front(directions_traveled)
		if (
			Input.is_action_just_released("engineer_move_up")
			and directions_traveled[0] == direction.Up
		):
			pop_front(directions_traveled)
		if (
			Input.is_action_just_released("engineer_move_down")
			and directions_traveled[0] == direction.Down
		):
			pop_front(directions_traveled)


func get_input():
	var input_direction = Input.get_vector(
		"engineer_move_left", "engineer_move_right", "engineer_move_up", "engineer_move_down"
	)
	velocity = input_direction * speed


func _physics_process(delta: float):
	get_input()
	move_and_slide()
	if velocity == Vector2(0, 0):
		current_state = state.Idle
	else:
		current_state = state.Walk

	try_animate()


func push(array: Array, value: direction):
	array.push_front(value)
	array.resize(4)  # arbitrary to keep the vector from becoming a performance issue


func pop_front(array: Array):
	array.pop_front()


func try_animate():
	if directions_traveled.front() != null:
		var animation_name = (
			state.keys()[current_state] + " " + direction.keys()[directions_traveled.front()]
		)
		if animation_name != sprite.get_animation():
			sprite.play(animation_name)
