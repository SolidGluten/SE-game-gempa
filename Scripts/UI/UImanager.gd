class_name UImanager
extends Node

const heart_full_path = "res://Sprites/heart/heart_full.png"
const heart_empty_path = "res://Sprites/heart/heart_empty.png"

@onready var death_screen = $DeathScreen
@onready var win_screen = $WinScreen
@onready var alert_icon = $AlertIcon
@export var quack_spawner: Node = null

var heart_count = 3
var current_health = 2
var heart_list: Array[TextureRect] = []

func _ready() -> void:
	playerHealth.health_changed.connect(self.sync_health_UI)
	playerHealth.dead.connect(self.enable_death_screen)

	death_screen.visible = false
	win_screen.visible = false

	var children = $HealthContainer.get_children()
	for child in children:
		if child is TextureRect:
			heart_list.append(child)

func _process(_delta: float) -> void:
	# Update the alert icon visibility based on the quake spawner's state
	if quack_spawner:
		(alert_icon as TextureRect).visible = quack_spawner.show_alert

func sync_health_UI(health: int) -> void:
	current_health = health

	for heart in heart_list:
		heart.texture = preload(heart_empty_path)
	
	for i in range(0, current_health):
		if i >= heart_count: break
		heart_list[i].texture = preload(heart_full_path)

func _exit_tree() -> void:
	playerHealth.health_changed.disconnect(self.sync_health_UI)

func enable_death_screen() -> void:
	death_screen.visible = true

func enable_win_screen() -> void:
	win_screen.visible = true
