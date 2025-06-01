class_name Hurtable
extends Area2D

@export var damage: int = 1

func _ready() -> void:
	connect("body_entered", self._on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		playerHealth.hurt(damage)
