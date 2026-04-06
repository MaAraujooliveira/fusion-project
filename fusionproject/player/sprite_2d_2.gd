extends Sprite2D

@export var player : CharacterBody2D
@export var radius := 100.0
@export var speed := 2.0

var angle := 0.0

func _process(delta):
	if not player:
		return
	
	var dir = get_global_mouse_position() - player.global_position
	var angle = dir.angle()
	
	var offset = Vector2(cos(angle), sin(angle)) * radius
	global_position = player.global_position + offset
	
	look_at(get_global_mouse_position())
