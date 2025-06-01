class_name Debris
extends Hurtable

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	super(body_rid, body, body_shape_index, local_shape_index)

	if body.is_in_group("player"):
		queue_free()

	if body is TileMapLayer:
		var tilemap = body
		var tile_coord = tilemap.get_coords_for_body_rid(body_rid)
		var tile_data = tilemap.get_cell_tile_data(tile_coord)

		if tile_data.get_custom_data("is_floor"):
			self.get_parent().queue_free()

