class_name GuideTrigger
extends Button

@export var guide_modal: Control

func _ready() -> void:
    if guide_modal: pressed.connect(self.enable_guide)

func enable_guide() -> void:
    guide_modal.visible = !guide_modal.visible