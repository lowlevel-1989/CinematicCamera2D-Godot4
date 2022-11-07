@tool
class_name CameraData2D
extends Node2D


## Contains parameters used by a CinematicCamera2D.
## Works as a logic camera to be used in combination with a CinematicCamera2D.


## Path to the node that the camera should follow.
@export var _follow_node: NodePath:
	set(value):
		_follow_node = value
		# Allows to see the change without reloading the scene in the editor.
		if Engine.is_editor_hint():
			follow_node = get_node_or_null(_follow_node)
## The node that this camera follows.
@onready var follow_node: Node = get_node_or_null(_follow_node)

## Camera offset.
@export var offset: Vector2 = Vector2.ZERO

## Camera zoom.
@export var zoom: Vector2 = Vector2.ONE

## Smoothing speed.
@export var smoothing_speed: float = 5.0

## Left limit of the camera.
@export var limit_left: int = -10000000:
	set(value):
		limit_left = value
		if Engine.is_editor_hint():
			queue_redraw()
## Top limit of the camera.
@export var limit_top: int = -10000000:
	set(value):
		limit_top = value
		if Engine.is_editor_hint():
			queue_redraw()
## Right limit of the camera.
@export var limit_right: int = 10000000:
	set(value):
		limit_right = value
		if Engine.is_editor_hint():
			queue_redraw()
## Bottom limit of the camera.
@export var limit_bottom: int = 10000000:
	set(value):
		limit_bottom = value
		if Engine.is_editor_hint():
			queue_redraw()


## Draws the canvas item.
## Used while in the editor to draw gizmos.
func _draw() -> void:
	if Engine.is_editor_hint():
		draw_multiline(PackedVector2Array([
			Vector2(limit_left, limit_top), Vector2(limit_left, limit_bottom),
			Vector2(limit_left, limit_bottom), Vector2(limit_right, limit_bottom),
			Vector2(limit_right, limit_bottom), Vector2(limit_right, limit_top),
			Vector2(limit_right, limit_top), Vector2(limit_left, limit_top)
		]), Color.YELLOW)


## Updates the position of the given camera.
## Takes this camera's limits into account.
func update_position(camera: Node2D) -> void:
	# Update camera position.
	if is_instance_valid(follow_node) and follow_node.is_inside_tree() and follow_node is Node2D:
		camera.global_position = follow_node.global_position
	else:
		camera.global_position = global_position
	# Make came stay within its limits.
	var camera_bounds = get_viewport_rect().size * Vector2(1 / zoom.x, 1 / zoom.y) / 2
	var min_x = global_position.x + limit_left + camera_bounds.x - offset.x
	var min_y = global_position.y + limit_top + camera_bounds.y - offset.y
	var max_x = global_position.x + limit_right - camera_bounds.x - offset.x
	var max_y = global_position.y + limit_bottom - camera_bounds.y - offset.y
	camera.global_position.x = clamp(camera.global_position.x, min_x, max_x)
	camera.global_position.y = clamp(camera.global_position.y, min_y, max_y)
