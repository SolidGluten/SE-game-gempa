class_name PlayerMovement
extends CharacterBody2D

@export var speed: float = 300.0
@export var crouch_speed: float = 75.0
@export var jump_velocity: float = -400.0

var current_speed: float
var is_crouching: bool = false
var is_facing_right: bool = false

@export var cayotee_duration: float = 0.2 # seconds
var cayotee_timer: float = 0.0

@onready var quake_manager: QuakeSpawner = get_node("../QuakeSpawner")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:

	if gameManager.current_state != GameManager.GameState.PLAYING:
		return

	# Add the gravity.
	if not is_on_floor():
		cayotee_timer -= delta
		velocity += get_gravity() * delta
		play_jump_anim()
	else:
		cayotee_timer = cayotee_duration

	# Handle jump
	if Input.is_action_just_pressed("jump_action") and (is_on_floor() or cayotee_timer > 0):
		velocity.y = jump_velocity

	# Get current speed
	current_speed = get_walk_speed()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * current_speed
		is_facing_right = direction > 0
		animated_sprite.flip_h = !is_facing_right
		play_walk_anim()
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		play_idle_anim()

	# Crouch
	if Input.is_action_pressed("crouch"):
		is_crouching = true
	else:
		is_crouching = false

	move_and_slide()

func get_walk_speed() -> float:
	if is_crouching or quake_manager.is_quake_active:
		return crouch_speed
	else:
		return speed

func play_walk_anim() -> void:
	if not is_on_floor(): return
	if is_crouching:
		animated_sprite.play("crouch")
	else:
		animated_sprite.play("walk")
	
func play_idle_anim() -> void:
	if not is_on_floor(): return
	if is_crouching:
		animated_sprite.play("crouch_idle")
	else:
		animated_sprite.play("idle")

func play_jump_anim() -> void:
	animated_sprite.play("jump")
