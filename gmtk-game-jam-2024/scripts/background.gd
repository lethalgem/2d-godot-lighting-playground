extends Sprite2D

@onready var spaceship = $"../../Spaceship"

@export var layer = 1
var speedOffset = 0.01


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = -spaceship.position * layer * speedOffset
