class_name SelectLevelButton
extends Button

@export var level_path = ""

func _ready() -> void:
    button_down.connect(self._on_button_pressed)

func _on_button_pressed() -> void:
    if level_path: levelManager.load_level(level_path)


