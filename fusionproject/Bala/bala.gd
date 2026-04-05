extends Area2D

var dir := Vector2.ZERO
var speed : float = 0.0
var damage : float = 0.0
var iniciate := false

func iniciar(s: float, d: float, direction: Vector2):
	speed = s
	damage = d
	dir = direction.normalized()
	iniciate = true


func _physics_process(delta: float) -> void:
	if not iniciate:
		return
	
	global_position += dir * speed * delta
