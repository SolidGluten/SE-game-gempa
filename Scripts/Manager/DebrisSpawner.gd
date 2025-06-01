class_name DebrisSpawner
extends Node

@export var debris_scene: PackedScene
@export var spawn_margin: float = 50.0
@export var spawn_interval: float = 0.5
@export var spawn_duration: float = 3.0

var spawn_timer: float = 0.0

@onready var timer = $Timer
@onready var camera:ScreenShake = get_viewport().get_camera_2d()


func _ready():
	spawn_timer = spawn_duration
	timer.wait_time = spawn_interval
	timer.timeout.connect(spawn_debris)

func _process(delta: float) -> void:
	if spawn_timer > 0 and !timer.is_stopped():
		spawn_timer -= delta
	
	if spawn_timer <= 0:
		timer.stop()

	if Input.is_action_just_pressed("spawn_debris_dev"):
		if timer.is_stopped():
			start_spawn_timer()
		else:
			timer.stop()
		
func start_spawn_timer() -> void:
	spawn_timer = spawn_duration
	timer.start()
	if camera: camera.start_shake(10.0, spawn_duration)

func spawn_debris() -> void:
	
	if not camera:
		print("Camera Not Found!")
		return

	var debris_instance = debris_scene.instantiate()
	get_tree().current_scene.add_child(debris_instance)
	
	# Get viewport and camera
	var viewport_size = get_viewport().size

	var top_left = Vector2(0, 0)
	var top_right = Vector2(viewport_size.x, 0)

	# Random X within screen bounds + optional margin
	var spawn_x = randf_range(top_left.x, top_right.x)
	var spawn_y = top_left.y 

	# Convert screen to world positions
	var spawn_pos = camera.get_screen_transform().affine_inverse() * Vector2(spawn_x, spawn_y)
	spawn_pos.y -= spawn_margin

	debris_instance.global_position = spawn_pos + camera.global_position
