class_name DialogueBox
extends Control

@export var label: Label


func set_text(text: String, timeout: int):
	visible = true
	label.text = text
	await get_tree().create_timer(timeout).timeout
	visible = false
