extends CharacterBody2D

@export var camera : CameraShake
@export var buff : Buff
@export var weakpons : Weakpons
@export var stats : PlayerStats
var recoil_velocity := Vector2.ZERO

func _ready() -> void:
	$Label.text = "Municoes : " + str(weakpons.municoes_ativas) + " / " + str(weakpons.max_municoes)
	$ProgressBar.max_value = stats.max_hp
	$ProgressBar.value = stats.hp

func _physics_process(delta: float) -> void:
	var input_dir = Vector2(
		Input.get_axis("A", "D"),
		Input.get_axis("W", "S")
	).normalized()
	
	# movimento base
	velocity = input_dir * stats.speed
	
	# adiciona recuo
	velocity += recoil_velocity
	
	# diminui recuo com o tempo (suaviza)
	recoil_velocity = recoil_velocity.lerp(Vector2.ZERO, 6 * delta)
	
	# partículas
	if input_dir.length() > 0:
		$CPUParticles2D.emitting = true
		$CPUParticles2D.direction = input_dir
	else:
		$CPUParticles2D.emitting = false
	
	$CPUParticles2D2.global_position = $Sprite2D2.global_position
	
	move_and_slide()

func _process(delta: float) -> void:
	weakpons.timer_arma += delta
	
	$Label.text = "Municoes : " + str(weakpons.municoes_ativas) + " / " + str(weakpons.max_municoes)
	
	$ProgressBar.max_value = stats.max_hp
	$ProgressBar.value = stats.hp
	
	if Input.is_action_pressed("shoot") and weakpons.timer_arma >= weakpons.cooldown:
		var final_dir = (get_global_mouse_position() - $Sprite2D2.global_position)
		$CPUParticles2D2.direction = -final_dir
		$CPUParticles2D2.emitting = true
		camera.shake(0.25,4)
		weakpons.atirar(final_dir,stats.bullets_qtd)
		await get_tree().create_timer(0.25).timeout
		$CPUParticles2D2.emitting = false
	
	if Input.is_action_just_pressed("Recaregar") and weakpons.municoes_ativas < weakpons.max_municoes:
		set_physics_process(false)
		weakpons.recaregar()
		await get_tree().create_timer(1.5).timeout
		set_physics_process(true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var enemy_stats := body.get_node("EnemyStats") as EnemyStats
		enemy_stats.take_damage(stats.damage)
		stats.take_damage(enemy_stats.damage)
