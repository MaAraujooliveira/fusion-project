
extends Node
class_name enemyMovement

@export var stats : EnemyStats
@export var enemy : CharacterBody2D
@export var walk_par : CPUParticles2D
@export var push_force := Vector2(130,130)
@export var target : Marker2D
@export var min_dist := 55

var player : CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	var dir = (player.global_position - enemy.global_position).normalized()
	var distance = enemy.global_position.distance_to(player.global_position)

	if distance <= min_dist:
		var push_distance = (push_force - enemy.global_position).normalized()
		enemy.velocity = push_force * push_distance
	else:
		enemy.velocity = stats.speed * dir
	
	walk_par.emitting = true
	walk_par.direction = dir
	
	enemy.move_and_slide()
