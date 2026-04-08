extends CharacterBody2D

@export var camera : CameraShake
@export var buff : Buff
@export var weakpons : Weakpons
@export var stats : PlayerStats
@export var cards : Cards_manager

var recoil_velocity := Vector2.ZERO
var inf := false

func _ready() -> void:
	$Label.text = "Municoes : " + str(weakpons.municoes_ativas) + " / " + str(weakpons.max_municoes)
	$ProgressBar.max_value = stats.max_hp
	$ProgressBar.value = stats.hp
	
	cards.add_to_ui(true)
	

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
	
	if Input.is_action_pressed("shoot") and weakpons.timer_arma >= weakpons.cooldown  and weakpons.municoes_ativas > 0:
		var final_dir = (get_global_mouse_position() - $Sprite2D2.global_position)
		$CPUParticles2D2.direction = -final_dir
		$CPUParticles2D2.emitting = true
		camera.shake(0.25,4)
		weakpons.atirar(final_dir,stats.bullets_qtd)
		await get_tree().create_timer(0.25).timeout
		$CPUParticles2D2.emitting = false

	if Input.is_action_just_pressed("Recaregar") and weakpons.municoes_ativas < weakpons.max_municoes:
		set_physics_process(false)
		
		var spriteP = $Sprite2D
		var sprite = $Sprite2D2
		
		var original_scale = sprite.scale
		var original_scale2 = spriteP.scale
		
		var tween = get_tree().create_tween()
		
		# 💥 crescer juntos
		tween.parallel().tween_property(sprite, "scale", original_scale * 1.2, 0.5)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)
		
		tween.parallel().tween_property(spriteP, "scale", original_scale2 * 1.2, 0.2)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)
		
		# 💥 voltar juntos
		tween.tween_property(sprite, "scale", original_scale, 0.15)
		tween.parallel().tween_property(spriteP, "scale", original_scale2, 0.15)
		
		weakpons.recaregar()
		
		await get_tree().create_timer(0.5).timeout
		
		set_physics_process(true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy") and not inf:
		var enemy_stats := body.get_node("EnemyStats") as EnemyStats
		inf = true
		enemy_stats.take_damage(stats.damage)
		stats.take_damage(enemy_stats.damage)

		await get_tree().create_timer(0.5).timeout
		inf = false
