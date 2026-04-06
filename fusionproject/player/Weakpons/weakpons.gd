extends Node2D
class_name Weakpons

@export var recuo := 125
@export var bala_scene : PackedScene
@export var player : CharacterBody2D
@export var stats : PlayerStats

var municoes := INF
var max_municoes := 5
var municoes_ativas := 5
var min_municoes := 0

var timer_arma := 0.0
var cooldown := 1.5


func _process(delta):
	timer_arma += delta

func recaregar():
	municoes_ativas = max_municoes

func atirar(dir: Vector2, qtd: int):
	if timer_arma < cooldown:return
	if municoes_ativas <= min_municoes:return
	
	timer_arma = 0
	player.recoil_velocity -= dir * recuo
	municoes_ativas -= 1
	
	var spread_total = 15.0 # graus
	
	
	for i in range(qtd):
		if not bala_scene:
			return
		
		var bala = bala_scene.instantiate()
		
		# calcula spread distribuído
		var t = 0.0
		if qtd > 1:
			t = float(i) / float(qtd - 1) # vai de 0 a 1
		
		var angle_offset = deg_to_rad(-spread_total/2 + spread_total * t)
		var new_dir = dir.rotated(angle_offset)
		
		bala.global_position = global_position
		bala.iniciar(stats.bullet_speed, stats.damage, new_dir,"BalaPlayer","Enemy")
		
		get_tree().current_scene.add_child(bala)
