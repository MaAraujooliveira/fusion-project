extends CharacterBody2D

@export var stats : PlayerStats

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
