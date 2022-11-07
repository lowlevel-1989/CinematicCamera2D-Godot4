class_name TestPlayer
extends CharacterBody2D


@export var speed: float = 300.0


func _process(_delta: float) -> void:
	var horizontal = Input.get_axis("ui_left", "ui_right")
	var vertical = Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(horizontal, vertical) * speed


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		queue_free()
