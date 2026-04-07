extends Node2D

@export var hp := 100
@export var max_hp := 100

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		get_tree().quit()

func _process(delta: float) -> void:
	$Label.text = str(hp) + " / " + str(max_hp)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var enemy_stats := body.get_node("EnemyStats") as EnemyStats
		body.queue_free()
		take_damage(enemy_stats.damage)
