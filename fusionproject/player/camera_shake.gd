extends Camera2D
class_name CameraShake

var shake_time := 0.0
var shake_strength := 0.0

func _process(delta):
	if shake_time > 0:
		shake_time -= delta
		
		offset = Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * shake_strength
	else:
		offset = Vector2.ZERO

func shake(time: float, strength: float):
	shake_time = time
	shake_strength = strength
