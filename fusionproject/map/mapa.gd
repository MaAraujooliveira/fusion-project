extends Node

@export var enemy_scene : PackedScene
@export var player : CharacterBody2D
@export var base : Node2D

# ⏱️ TEMPO
var spawn_timer := 0.0
@export var spawn_cooldown := 1.0

# 📍 SPAWN
@export var spawn_radius := 2000.0
@export var min_spawn_radius := 1500.0

# 👾 QUANTIDADE
@export var spawn_qtd := 1

# 📈 DIFICULDADE
var difficulty_time := 0.0
@export var difficulty_increase_time := 10.0 
var multiplier := 1.0

func _process(delta):
	if player == null:
		return

	# ⏱️ tempo normal
	spawn_timer += delta
	difficulty_time += delta

	# 🔥 aumenta dificuldade
	if difficulty_time >= difficulty_increase_time:
		difficulty_time = 0.0
		increase_difficulty()

	# 👾 spawn
	if spawn_timer >= spawn_cooldown:
		spawn_timer = 0.0
		spawn_enemy()

# 💥 AUMENTO DE DIFICULDADE
func increase_difficulty():
	multiplier += 0.2
	
	# aumenta quantidade de inimigos
	spawn_qtd = int(1 + multiplier)
	
	# diminui tempo entre spawn
	spawn_cooldown = max(0.3, spawn_cooldown - 0.05)

	print("Dificuldade:", multiplier)

# 👾 SPAWN
func spawn_enemy():
	for i in range(spawn_qtd):
	
		var enemy = enemy_scene.instantiate()
		if enemy == null:
			continue
		
		var pos = get_spawn_position()
		
		var move = enemy.get_node("EnemyMovement") as enemyMovement
		
		move.iniciar(base, multiplier)
		
		enemy.global_position = pos
		get_parent().add_child(enemy)

# 📍 POSIÇÃO
func get_spawn_position():
	var angle = randf() * TAU
	var dir = Vector2(cos(angle), sin(angle))
	var distance = randf_range(min_spawn_radius, spawn_radius)
	
	return player.global_position + dir * distance
