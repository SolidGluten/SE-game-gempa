class_name Debris
extends Hurtable

@export var enable_life_time: bool = true
@export var life_time: float = 2.0
@export var particle_effect: PackedScene

func _process(delta: float) -> void:
	if not enable_life_time:
		return
	
	life_time -= delta
	if life_time <= 0:
		self.get_parent().queue_free()


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	super(body_rid, body, body_shape_index, local_shape_index)

	if body.is_in_group("player"):
		self.get_parent().queue_free()

	if body.is_in_group("furniture"):
		self.get_parent().queue_free()

	if body is TileMapLayer:
		var tilemap = body
		var tile_coord = tilemap.get_coords_for_body_rid(body_rid)
		var tile_data = tilemap.get_cell_tile_data(tile_coord)

		if tile_data.get_custom_data("is_floor"):
			self.get_parent().queue_free()

func _exit_tree() -> void:
	if particle_effect:
		var particle = particle_effect.instantiate()
		particle.global_position = global_position
		get_tree().current_scene.add_child.call_deferred(particle)
