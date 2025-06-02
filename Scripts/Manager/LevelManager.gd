class_name LevelManager
extends Node

func _ready() -> void:
    playerHealth.dead.connect(self.reset_current_scene)

func reset_current_scene() -> void:
    get_tree().reload_current_scene()

func load_level(level_path) -> void:
    var scene := load(level_path)
    if scene: get_tree().change_scene_to_packed(scene)
    else: printerr("Loaded scene is not found.")

func _exit_tree() -> void:
    playerHealth.dead.disconnect(self.reset_current_scene)