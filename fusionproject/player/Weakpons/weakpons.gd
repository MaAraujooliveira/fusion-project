extends Node2D
class_name Weakpons

@export var recuo := 125
@export var bala_scene : PackedScene

var timer_arma := 0.0
var cooldown := 2.5

func atirar():
	var bala : Node2D
	if bala_scene:
		bala = bala_scene.instantiate()
	var spread = deg_to_rad(30)
	bala.global_position = global_position
	bala.rotation_degrees = spread
	if bala:
		get_tree().current_scene.add_child(bala)
