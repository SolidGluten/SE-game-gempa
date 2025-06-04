class_name ExitDoor
extends Interactable

@export var next_level_path := ""

func interact() -> void:
	if not playerInventory.has_key:
		printerr("You need a key to exit this level.")
		return

	if next_level_path: levelManager.load_level(next_level_path)
	else: printerr("Level path not assigned.")
