class_name ScreenShake
extends Camera2D

@export var shake_strength: float
@export var shake_duration: float
@export var shake_decay: float
@export var is_shake: bool = false

var current_impact: float
var shake_timer: float

func _process(delta: float) -> void:
	if shake_timer > 0:
		shake_timer -= delta

		var t = shake_timer / shake_duration
		var current_strength = lerp(0.0, shake_strength, pow(t, shake_decay))

		var offset_x = randf_range(-current_strength, current_strength)
		var offset_y = randf_range(-current_strength, current_strength)
		offset = Vector2(offset_x, offset_y)

	else:
		offset = Vector2.ZERO

	if Input.is_action_just_pressed("shake_dev"):
		start_shake()
		
func start_shake(strength: float = 10.0, duration: float = 3.0, decay: float = 1.0) -> void:
	shake_strength = strength
	shake_duration = duration
	shake_timer = duration
	shake_decay = decay
