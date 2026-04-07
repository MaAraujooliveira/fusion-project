extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player_stats = body.get_node("PlayerStats") as PlayerStats
		player_stats.add_xp(10)
		queue_free()
