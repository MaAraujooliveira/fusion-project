extends Node
class_name PlayerStats

@export var hp := 10.0
@export var sprite : Sprite2D
@export var speed := 600.0
@export var damage := 1.0
@export var bullet_speed := 750
@export var bullets_qtd := 1
@export var picked_qtd := 1

@export var xp_bar : ProgressBar
@export var ui : Buff

var xp := 0
var max_xp := 100
var max_hp

func _ready() -> void:
	max_hp = hp

func take_damage(amount):
	hp -= amount
	await piscar(Color.RED,0.25)
	if hp <= 0:
		get_tree().change_scene_to_file("res://TelaInicial/TelaInicial.tscn")



func add_xp(amount):
	xp += amount
	verificar_xp()
	xp_bar.max_value = max_xp
	xp_bar.value = xp

func verificar_xp():
	while xp >= max_xp:
		xp -= max_xp
		max_xp = clamp(50 + max_xp,1,2500)

		if not ui.visible:
			ui.mostrar_ui()

func piscar(color,time):
	sprite.modulate = color
	await get_tree().create_timer(time).timeout
	sprite.modulate = Color.WHITE
