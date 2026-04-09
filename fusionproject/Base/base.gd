extends Node2D
class_name Base

@export var hp := 100
@export var max_hp := 100
@export var coin_scene : PackedScene
@export var spawn_radius := 2000.0
@export var min_spawn_radius := 1000.0
@export var coin_amount := 5
@export var spawn_time := 2.0

var timer := 0.0

func _ready() -> void:
	queue_redraw()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		get_tree().change_scene_to_file("res://TelaInicial/TelaInicial.tscn")

func _process(delta: float) -> void:
	$Label.text = "Base HP: " + str(hp) + " / " + str(max_hp)

	timer += delta
	
	if timer >= spawn_time:
		timer = 0
		spawn_coins()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var enemy_stats := body.get_node("EnemyStats") as EnemyStats
		
		if enemy_stats:
			take_damage(enemy_stats.damage)
		
		body.queue_free()

func spawn_coins():
	for i in range(coin_amount):
		
		var coin = coin_scene.instantiate()
		get_tree().current_scene.add_child(coin)
		coin.global_position = get_spawn_position()
		
		# 💥 EFEITO BOUNCE
		coin.scale = Vector2.ZERO
		
		var tween = create_tween()
		tween.tween_property(coin, "scale", Vector2(1.3, 1.3), 0.45)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)
		
		tween.tween_property(coin, "scale", Vector2(1, 1), 0.5)

func _draw():
	var shape = $StaticBody2D/Area2D2/CollisionShape2D3.shape
	
	if shape is CircleShape2D:
		var radius = shape.radius
		
		draw_circle(Vector2.ZERO, radius, Color(0.0, 1.0, 0.0, 1.0),false,50) # verde transparente

func get_spawn_position():
	var angle = randf() * TAU
	var dir = Vector2(cos(angle), sin(angle))
	var distance = randf() * spawn_radius
	
	return  dir * distance
