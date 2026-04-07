extends Node2D
class_name Base

@export var hp := 100
@export var max_hp := 100
@export var coin_scene : PackedScene
@export var spawn_radius := 200.0
@export var coin_amount := 5
@export var spawn_time := 2.0

var timer := 0.0


func take_damage(amount):
	hp -= amount
	if hp <= 0:
		get_tree().quit()

func _process(delta: float) -> void:
	$Label.text = str(hp) + " / " + str(max_hp)

	timer += delta
	
	if timer >= spawn_time:
		timer = 0
		spawn_coins()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var enemy_stats := body.get_node("EnemyStats") as EnemyStats
		body.queue_free()
		take_damage(enemy_stats.damage)

func spawn_coins():
	for i in range(coin_amount):
		var angle = randf_range(0, TAU)
		var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
		
		var coin = coin_scene.instantiate()
		get_tree().current_scene.add_child(coin)
		coin.global_position = global_position + offset
