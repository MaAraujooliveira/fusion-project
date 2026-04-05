extends CharacterBody2D

@export var buff : Buff
@export var weakpons : Weakpons
@export var stats : PlayerStats

func _ready() -> void:
	buff.mostrar_ui()

func _physics_process(delta: float) -> void:
	var dir = Vector2(Input.get_axis("A","D"),Input.get_axis("W","S"))
	if dir:
		velocity = stats.speed * dir
		$CPUParticles2D.emitting = true
		
		$CPUParticles2D.direction = dir
	else:
		velocity = Vector2.ZERO
		$CPUParticles2D.emitting = false
	
	
	move_and_slide()

func _process(delta: float) -> void:
	weakpons.timer_arma += delta
	if Input.is_action_pressed("shoot") and weakpons.timer_arma >= weakpons.cooldown:
		var final_dir = (get_global_mouse_position() - global_position )
		weakpons.atirar(final_dir,3)
