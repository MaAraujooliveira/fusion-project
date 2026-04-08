extends Button
class_name CardButton

@export var cards : Cards_manager

var build_scene : PackedScene
var can_use := true

func iniciar(Name, build: PackedScene,c:Cards_manager):
	text = Name
	build_scene = build
	cards = c
	
	pressed.connect(_on_pressed)

func _on_pressed():
	if not can_use:
		return
	
	aplicar_build()

func aplicar_build():
	if build_scene:
		var build = build_scene.instantiate()
		build.cards = cards
		get_tree().current_scene.add_child(build)
	
	queue_free()
