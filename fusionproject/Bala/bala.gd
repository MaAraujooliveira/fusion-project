extends Area2D

var dir := Vector2.ZERO
var speed : float = 0.0
var damage : float = 0.0
var iniciate := false
var meu_grupo : String
var alvo : String

func iniciar(s: float, d: float, direction: Vector2,m,a):
	speed = s
	damage = d
	dir = direction.normalized()
	iniciate = true
	meu_grupo = m
	alvo = a


func _physics_process(delta: float) -> void:
	if not iniciate:
		return
	
	global_position += dir * speed * delta


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
