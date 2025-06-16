class_name ExitDoor
extends Interactable

@export var next_level_path := ""
@export var uiManager: UImanager

func interact() -> void:
	if playerInventory.has_key:
		uiManager.enable_win_screen(next_level_path)
	else:
		printerr("You need a key to exit this level.")

	# if next_level_path: levelManager.load_level(next_level_path)
	# else: printerr("Level path not assigned.")
