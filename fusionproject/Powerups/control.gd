extends Control

func _ready() -> void:
	# Conecta os sinais dos botões às funções
	$Button.pressed.connect(_on_button_pressed)
	$Button2.pressed.connect(_on_button2_pressed)
	$Button3.pressed.connect(_on_button3_pressed)

func _on_button_pressed() -> void:
	print("Button 1 clicado")

func _on_button2_pressed() -> void:
	print("Button 2 clicado")

func _on_button3_pressed() -> void:
	print("Button 3 clicado")

func _process(delta: float) -> void:
	pass
