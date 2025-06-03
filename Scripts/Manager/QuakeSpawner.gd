class_name QuakeSpawner
extends Node

@export var debris_scene: PackedScene
@export var spawn_margin_top: float = 50.0
@export var spawn_padding_x: float = 20.0
@export var spawn_debris_interval: float = 0.3

@export var quake_duration: float = 5.0
var quake_timer: float = 0.0

@export var min_time_before_quake: float = 8.0
@export var max_time_before_quake: float = 12.0
var spawn_timer: float = 0.0

@onready var timer = $Timer
@onready var camera:ScreenShake = get_viewport().get_camera_2d()

@export var show_alert_time: float = 2.0
@export var show_alert:bool = false

signal quake_started
signal quake_ended

func _ready():
	quake_timer = quake_duration
	spawn_timer = get_random_time()

	timer.wait_time = spawn_debris_interval
	timer.timeout.connect(spawn_debris)

func _process(delta: float) -> void:
	# spawn quake
	if spawn_timer > 0:
		spawn_timer -= delta
		show_alert = spawn_timer <= show_alert_time
		# print("Spawn Timer: ", spawn_timer)
	else:
		emit_signal("quake_started")
		start_spawn_timer() 
		spawn_timer = get_random_time()
	
	# track quake duration
	if quake_timer > 0 and !timer.is_stopped():
		quake_timer -= delta
	
	if quake_timer <= 0:
		emit_signal("quake_ended")
		quake_timer = quake_duration
		timer.stop()

	# if Input.is_action_just_pressed("spawn_debris_dev"):
	# 	if timer.is_stopped():
	# 		start_spawn_timer()
	# 	else:
	# 		timer.stop()
		
func start_spawn_timer() -> void:
	timer.start()
	if camera: camera.start_shake(10.0, quake_duration)

func spawn_debris() -> void:
	if not camera:
		print("Camera Not Found!")
		return

	var debris_instance = debris_scene.instantiate()
	get_tree().current_scene.add_child(debris_instance)
	
	# Get viewport and camera
	var viewport_size = get_viewport().size

	var top_left = Vector2(spawn_padding_x, 0)
	var top_right = Vector2(viewport_size.x - spawn_padding_x, 0)

	# Random X within screen bounds + optional margin
	var spawn_x = randf_range(top_left.x, top_right.x)
	var spawn_y = top_left.y 

	# Convert screen to world positions
	var spawn_pos = camera.get_screen_transform().affine_inverse() * Vector2(spawn_x, spawn_y)
	spawn_pos.y -= spawn_margin_top

	debris_instance.global_position = spawn_pos + camera.global_position

func get_random_time() -> float:
	return randf_range(min_time_before_quake, max_time_before_quake)