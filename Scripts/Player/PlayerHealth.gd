class_name PlayerHealth
extends Node

const max_health: int = 3
var current_health: int

signal health_changed(curr_hp: int)
signal dead

func _ready() -> void:
    current_health = max_health

func hurt(dmg: int) -> void: 
    current_health = max(0, current_health - dmg)
    emit_signal("health_changed", current_health)

    if current_health <= 0:
        emit_signal("dead")
        current_health = max_health

func heal(hp: int) -> void:
    current_health = min(max_health, current_health + hp)
    emit_signal("health_changed", current_health)
