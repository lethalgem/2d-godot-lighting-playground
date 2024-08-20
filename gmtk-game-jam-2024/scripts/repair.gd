class_name Repair
extends Node2D

@export var engineer: Engineer
@export var level: ShipIndoors

signal computer_repaired

var is_touching_computer: bool = false
var touching_computer: ComputerUseArea = null
var computer_progress_speed: int = 50
var computer_to_repair_id: ShipIndoors.computers = -1  # value for 'no computer'
var last_computer_repaired_id: ShipIndoors.computers = -1  # value for 'no computer'


func _ready():
	assign_next_computer_to_repair()


func _process(delta: float) -> void:
	if is_touching_computer and Input.is_action_pressed("interact_with_computer"):
		if touching_computer.computer_id == computer_to_repair_id:
			var repair_progress = touching_computer._update_progress(
				delta * computer_progress_speed
			)
			if repair_progress >= 100:
				computer_successfully_repaired(touching_computer.computer_id)


func _on_computer_detection_area_area_entered(area: Area2D) -> void:
	if area is ComputerUseArea:
		set_next_to_computer(true, area)


func _on_computer_detection_area_area_exited(area: Area2D) -> void:
	if area is ComputerUseArea:
		set_next_to_computer(false, area)


func computer_successfully_repaired(id):
	last_computer_repaired_id = id
	var computer = level.get_computer_with_id(computer_to_repair_id)
	computer.computer_repaired()
	computer_to_repair_id = -1
	computer_repaired.emit()
	print("successfully repaired computer" + get_computer_name(id))


func assign_next_computer_to_repair():
	var random_id = RandomNumberGenerator.new().randi_range(0, 3)
	if random_id != last_computer_repaired_id:
		computer_to_repair_id = random_id
		var computer = level.get_computer_with_id(computer_to_repair_id)
		computer.computer_needs_to_be_repaired()


func get_computer_name(id: int) -> String:
	return ShipIndoors.computers.keys()[id]


func set_next_to_computer(is_touching: bool, area: ComputerUseArea):
	is_touching_computer = is_touching
	if is_touching:
		touching_computer = area
		print("touching computer " + get_computer_name(area._get_computer_id()))
	else:
		touching_computer = null
		print("no longer touching computer " + get_computer_name(area._get_computer_id()))


func _on_piloting_shields_down() -> void:
	assign_next_computer_to_repair()
