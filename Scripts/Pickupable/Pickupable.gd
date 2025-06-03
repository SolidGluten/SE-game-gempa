class_name Pickupable
extends Area2D

func _ready() -> void:
	area_entered.connect(self.pick_up)

func pick_up(area: Area2D) -> void:
	self.get_parent().queue_free()
