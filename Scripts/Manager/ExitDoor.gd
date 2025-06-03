class_name ExitDoor
extends Interactable

@export var next_level_path := ""

func interact() -> void:
    if next_level_path: levelManager.load_level(next_level_path)
    else: printerr("Level path not assigned.")
