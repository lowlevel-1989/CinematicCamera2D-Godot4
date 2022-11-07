class_name AreaTrigger
extends Area2D


@export var cinematic_camera: NodePath

@export var virtual_camera_1: NodePath
@export var virtual_camera_2: NodePath


func _ready() -> void:
	body_exited.connect(_on_body_exited)


func _on_body_exited(body: Node2D) -> void:
	if body.global_position.x < global_position.x:
		get_node(cinematic_camera).virtual_camera = get_node(virtual_camera_1)
	else:
		get_node(cinematic_camera).virtual_camera = get_node(virtual_camera_2)
