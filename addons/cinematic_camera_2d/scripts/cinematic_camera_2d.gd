@tool
class_name CinematicCamera2D
extends Camera2D


## Cinematic camera 2D node.
## Uses a CameraData2D to create smooth transitions between cameras.


## Node path to the camera metadata node to use.
@export var _camera_data: NodePath:
	set(value):
		_camera_data = value
		# Allows to see the change without reloading the scene in the editor.
		if Engine.is_editor_hint():
			camera_data = get_node_or_null(_camera_data)
## Reference to camera metadata node.
## Change this value to transition to another camera.
@onready var camera_data: CameraData2D = get_node_or_null(_camera_data)


## Called every frame.
func _process(delta: float) -> void:
	if is_instance_valid(camera_data) and camera_data.is_inside_tree():
		# Update camera position.
		camera_data.update_position(self)
		# Set camera smoothing.
		position_smoothing_speed = camera_data.smoothing_speed
		# Update camera zoom.
		if camera_data.zoom.x != 0.0:
			zoom.x = lerp(zoom.x, camera_data.zoom.x, delta * camera_data.smoothing_speed)
		if camera_data.zoom.y != 0.0:
			zoom.y = lerp(zoom.y, camera_data.zoom.y, delta * camera_data.smoothing_speed)
		# Update camera offset.
		offset = lerp(offset, camera_data.offset, delta * camera_data.smoothing_speed)
