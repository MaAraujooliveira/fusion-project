extends Button
class_name CardButton

var build_scene : PackedScene
var can_use := true

func iniciar(Name, build: PackedScene):
	text = Name
	build_scene = build
	
	pressed.connect(_on_pressed)

func _on_pressed():
	if not can_use:
		return
	
	aplicar_build()

func aplicar_build():
	if build_scene:
		var build = build_scene.instantiate()
		get_tree().current_scene.add_child(build)
	
	queue_free()
