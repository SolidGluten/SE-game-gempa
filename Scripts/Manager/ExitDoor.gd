class_name ExitDoor
extends Node

@export var next_level_path := ""

func open_door(body: Node2D) -> void:
    if next_level_path and body.is_in_group("player"):
        levelManager.load_level(next_level_path)
