class_name RightSplitscreenOverlay
extends SubViewportContainer

@onready
var right_splitscreen_viewport_container: SubViewportContainer = %RightSplitscreenViewportContainer
@onready var right_splitscreen_viewport: SubViewport = %RightSplitscreenViewport
@onready var splitscreen_hbox_container: HBoxContainer = %SplitscreenHBoxContainer
@onready var right_splitscreen_overlay_viewport: SubViewport = %RightSplitscreenOverlaySubViewport


func _ready():
	await splitscreen_hbox_container.sort_children

	# overlay the repair viewport onto the zoomed ship viewport
	self.global_position = right_splitscreen_viewport_container.global_position
	right_splitscreen_overlay_viewport.size = right_splitscreen_viewport.size
