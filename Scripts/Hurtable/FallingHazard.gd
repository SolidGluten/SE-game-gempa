class_name FallingHazard
extends RigidBody2D

@export var fall_gravity = 1.0
var camera

func _ready() -> void:
    camera = get_viewport().get_camera_2d()
    gravity_scale = 0.0

func fall(body: Node2D) -> void:
    gravity_scale = fall_gravity
    if camera:
        (camera as ScreenShake).start_shake(5.0, 1.0)
