class_name PlayerHealth
extends Node

const max_health: int = 3
var current_health: int

signal health_changed(curr_hp: int)
signal dead

func _ready() -> void:
    current_health = max_health

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("damage_player_dev"):
        hurt(1)

func hurt(dmg: int) -> void: 
    current_health = max(0, current_health - dmg)
    emit_signal("health_changed", current_health)

    if current_health <= 0:
        emit_signal("dead")
        current_health = max_health

func heal(hp: int) -> void:
    current_health = min(max_health, current_health + hp)
    emit_signal("health_changed", current_health)
