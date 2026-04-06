extends Sprite2D

@export var player : CharacterBody2D
@export var radius := 100.0

func _process(delta):
	if not player:
		return
	
	# direção do mouse
	var dir = get_global_mouse_position() - player.global_position
	var angle = dir.angle()
	
	# posição da arma orbitando o player
	var offset = Vector2(cos(angle), sin(angle)) * radius
	global_position = player.global_position + offset
	
	# arma sempre olha para o mouse
	rotation = angle
