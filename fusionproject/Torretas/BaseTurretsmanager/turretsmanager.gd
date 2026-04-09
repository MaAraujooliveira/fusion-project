extends Node2D
class_name TurretManager

@export var stats : TurretStats
@export var distance : EnemyFinder
@export var weapons : WeakponsTurret
@export var cards : Cards_manager

var on_mouse := false
var on_spawned := false
var can_place_here := true
var replaced := false
var replaced_qtd := 0
var areas_dentro := 0


func seguir_mouse():
	if not on_spawned:
		global_position = get_global_mouse_position()

		replaced = replaced_qtd > 0

		if areas_dentro <= 0:
			$Sprite2D.modulate = Color(1, 0, 0, 0.5)

		if Input.is_action_just_pressed("PlaceTower") and can_place_here:
			on_spawned = true
			$Sprite2D.modulate = Color(1, 1, 1, 1)


func _process(delta: float) -> void:
	seguir_mouse()
	
	if not on_spawned:
		return
	
	var target = distance.find_target()
	
	if on_mouse:
		queue_redraw()
	
	weapons.timer_arma += delta
	if weapons.timer_arma >= weapons.cooldown:
		if target:
			var final_dir = (target.global_position - global_position).normalized()
			weapons.atirar(final_dir, 1)
			weapons.timer_arma = 0
	
	if target:
		look_at(target.global_position)
	
	if Input.is_action_just_pressed("escluirTurret") and on_mouse and not replaced:
		on_spawned = false
		replaced_qtd += 1


	if not can_place_here and not on_spawned:
		$Sprite2D.modulate = Color(1, 0, 0, 0.5)
	elif not on_spawned and areas_dentro > 0:
		$Sprite2D.modulate = Color(1, 1, 1, 1)


func _draw():
	if not on_mouse:
		return
		
	draw_arc(Vector2.ZERO, stats.range, 0, TAU, 64, Color.RED, 3)


func _on_area_2d_mouse_entered() -> void:
	if not on_spawned:
		return
		
	on_mouse = true
	$Sprite2D.modulate = Color(0.86, 0.0, 0.0, 1.0)


func _on_area_2d_mouse_exited() -> void:
	if not on_spawned:
		return
		
	on_mouse = false
	$Sprite2D.modulate = Color(1, 1, 1, 1)
	queue_redraw()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Base"):
		can_place_here = false
		$Sprite2D.modulate = Color(0, 0, 0, 0.7)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Base"):
		if areas_dentro > 0:
			$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 0.7)
			can_place_here = true


# 💥 RANGE (permite)
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("BaseRange"):
		areas_dentro += 1
		
		if areas_dentro > 0:
			can_place_here = true
			$Sprite2D.modulate = Color(1, 1, 1, 1)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("BaseRange"):
		areas_dentro -= 1
		
		if areas_dentro <= 0:
			can_place_here = false
			$Sprite2D.modulate = Color(1, 0, 0, 0.5)
