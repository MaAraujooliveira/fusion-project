extends Node
class_name EnemyStats

@export var enemy : CharacterBody2D
@export var hp := 10
@export var speed := 300
@export var damage := 1

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		enemy.queue_free()
