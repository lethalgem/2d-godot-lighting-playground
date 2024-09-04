extends ParallaxBackground

var nodes = {}

#func _ready():
#for node in get_children():
#if node is Node2D:
#nodes[node] = [node.position, node.scale]
#
#
#func _process(delta):
#var viewport_size = get_viewport().size
#var camera = get_viewport().get_camera_2d()
#
#for node in nodes:
#node.position = (
#nodes[node][0]
#+ camera.zoom * Vector2(viewport_size.x / 2, viewport_size.y / 2) * node.zoom_factor
#- Vector2(viewport_size.x / 2, viewport_size.y / 2) * node.zoom_factor
#)
#node.scale = nodes[node][1] + (Vector2(1, 1) - camera.zoom) * node.zoom_factor
