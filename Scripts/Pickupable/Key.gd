class_name Key
extends Pickupable

func pick_up(area: Area2D) -> void:
    playerInventory.has_key = true
    print("Key picked up!")
    super(area)