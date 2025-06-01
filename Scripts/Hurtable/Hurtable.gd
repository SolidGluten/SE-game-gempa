class_name Hurtable
extends Area2D

@export var damage: int = 1

func _ready() -> void:
	connect("body_shape_entered", self._on_body_shape_entered)

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		playerHealth.hurt(damage)
