extends Node
class_name PlayerStats

@export var hp := 10.0
@export var sprite : Sprite2D
@export var speed := 600.0
@export var damage := 1.0
@export var bullet_speed := 750
@export var bullets_qtd := 1
@export var picked_qtd := 1

var max_hp

func _ready() -> void:
	max_hp = hp

func take_damage(amount):
	hp -= amount
	await piscar(Color.RED,0.25)
	if hp <= 0:
		get_tree().reload_current_scene()

func piscar(color,time):
	sprite.modulate = color
	await get_tree().create_timer(time).timeout
	sprite.modulate = Color.WHITE
