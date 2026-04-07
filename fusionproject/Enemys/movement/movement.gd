extends Node
class_name enemyMovement

@export var stats : EnemyStats
@export var enemy : CharacterBody2D
@export var walk_par : CPUParticles2D
@export var push_force := Vector2(130,130)
@export var min_dist := 55

var base : Base
var player : CharacterBody2D
var target : Node2D


func iniciar(b):
	base = b
	
	# 🔥 escolhe alvo UMA VEZ
	if randf() < 0.5:
		target = base
	else:
		target = player


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float) -> void:
	if not target:
		return
	
	var dir = (target.global_position - enemy.global_position).normalized()
	var distance = enemy.global_position.distance_to(target.global_position)

	# 💥 empurra só se for player
	if target == player and distance <= min_dist:
		var push_dir = (enemy.global_position - player.global_position).normalized()
		enemy.velocity = push_dir * push_force.length()
	else:
		enemy.velocity = stats.speed * dir
	
	walk_par.emitting = true
	walk_par.direction = dir
	
	enemy.move_and_slide()
