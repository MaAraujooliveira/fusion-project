extends Node

@export var enemy_scene : PackedScene
@export var player : CharacterBody2D

# ⏱️ TEMPO
var spawn_timer := 0.0
@export var spawn_cooldown := 2.0

# 👾 CONTROLE
var enemys := []
const MAX_ENEMYS := 200

# 📍 SPAWN
@export var spawn_radius := 2000.0
@export var min_spawn_radius := 1500.0
@export var spawn_qtd := 1


func _process(delta):
	if player == null:
		return

	spawn_timer += delta

	if spawn_timer >= spawn_cooldown:
		spawn_timer = 0.0
		spawn_enemy()


func spawn_enemy():
	for i in range(spawn_qtd):
		if enemys.size() >= MAX_ENEMYS:
			return
		
		var enemy = enemy_scene.instantiate()
		if enemy == null:
			continue
		
		var pos = get_spawn_position()
		var move = enemy.get_node("EnemyMovement") as enemyMovement
		move.target = $Base
		enemy.global_position = pos
		
		get_parent().add_child(enemy)
		enemys.append(enemy)


func get_spawn_position():
	var angle = randf() * TAU
	var dir = Vector2(cos(angle), sin(angle))
	var distance = randf_range(min_spawn_radius, spawn_radius)
	
	return player.global_position + dir * distance
