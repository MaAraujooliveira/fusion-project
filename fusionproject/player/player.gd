extends CharacterBody2D

@export var buff : Buff
@export var weakpons : Weakpons
@export var stats : PlayerStats
var recoil_velocity := Vector2.ZERO

func _ready() -> void:
	buff.mostrar_ui()

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
	
	move_and_slide()

func _process(delta: float) -> void:
	weakpons.timer_arma += delta
	if Input.is_action_pressed("shoot") and weakpons.timer_arma >= weakpons.cooldown:
		var final_dir = (get_global_mouse_position() - global_position )
		weakpons.atirar(final_dir,3)
