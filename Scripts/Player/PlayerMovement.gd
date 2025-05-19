class_name PlayerMovement
extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
var is_facing_right: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		play_jump_anim()

	# Handle jump
	if Input.is_action_just_pressed("jump_action") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		is_facing_right = direction > 0
		animated_sprite.flip_h = !is_facing_right
		play_walk_anim()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		play_idle_anim()

	move_and_slide()

func play_walk_anim() -> void:
	if not is_on_floor(): return
	animated_sprite.play("walk")
	
func play_idle_anim() -> void:
	if not is_on_floor(): return
	animated_sprite.play("idle")

func play_jump_anim() -> void:
	animated_sprite.play("jump")
