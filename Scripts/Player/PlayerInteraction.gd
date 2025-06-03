class_name PlayerInteraction
extends Area2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") && has_overlapping_areas():
		var areas = get_overlapping_areas()
		for area in areas:
			if area is Interactable: 
				area.interact()
