extends Node
class_name EnemyStats

@export var enemy : CharacterBody2D
@export var enemy_sprite : Sprite2D
@export var hp := 10
@export var speed := 300
@export var damage := 1

func take_damage(amount):
	hp -= amount
	await piscar(Color.RED,0.25)
	if hp <= 0:
		enemy.queue_free()

func piscar(color,time):
	enemy_sprite.modulate = color
	await get_tree().create_timer(time).timeout
	enemy_sprite.modulate = Color.WHITE
