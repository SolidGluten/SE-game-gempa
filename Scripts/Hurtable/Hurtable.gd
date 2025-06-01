class_name Hurtable
extends Area2D

@export var damage: int = 1

func body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        # player take damage
        pass



