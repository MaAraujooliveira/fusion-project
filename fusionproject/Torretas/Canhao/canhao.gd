extends Node2D

@export var stats : TurretStats
@export var distance : EnemyFinder
@export var weakpons : WeakponsTurret

var on_mouse := false
func _process(delta: float) -> void:
	if on_mouse:
		queue_redraw()
	weakpons.timer_arma += delta
	if weakpons.timer_arma >= weakpons.cooldown:
		var target = distance.find_target()
		if target:
			var final_dir = (target.global_position - global_position).normalized()
			weakpons.atirar(final_dir, 3)

func _draw():
	if not on_mouse:
		return
		
	draw_arc(
		Vector2.ZERO,
		stats.range,
		0,
		TAU,
		512,
		Color.RED,
		4
	)

func _on_area_2d_mouse_entered() -> void:
	on_mouse = true
	$Sprite2D.modulate = Color(0.863, 0.0, 0.0, 1.0)

func _on_area_2d_mouse_exited() -> void:
	on_mouse = false
	$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
	queue_redraw()
