class_name AlertIcon
extends Node

@onready var timer: Timer = $Timer

func _ready() -> void:
	self.visible = false  # Start with the icon hidden
	timer.timeout.connect(self.blink)

func blink() -> void:
	self.visible = !self.visible
	print("Blinking Alert Icon: ", self.visible)

func set_alert(state: bool) -> void:
	if(self.visible == state):
		return  # No change needed, exit early
	
	self.visible = state
	print("Setting Alert Icon: ", self.visible)
	if state: timer.start()
	else: timer.stop()
	# self.visible = true  # Ensure icon is visible when alert is off
