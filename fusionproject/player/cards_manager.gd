extends HBoxContainer
class_name Cards_manager

@export var size_x := 200
@export var cards_ui_scene : PackedScene
@export var stats : PlayerStats

var using_card := false
var cards_dic = CardsDictionary.cards
var max_cards := 7

# 🎯 Pega cartas aleatórias
func pick_random_cards() -> Array:
	var picked_cards := []
	var qtd = min(stats.picked_qtd, max_cards)
	
	for i in range(qtd):
		var key = cards_dic.keys().pick_random()
		var card = cards_dic[key]
		picked_cards.append(card)
	
	return picked_cards

# 🎯 Cria as cartas na tela
func add_to_ui():
	var picked = pick_random_cards()
	using_card = true
	
	for card in picked:
		var card_ui = cards_ui_scene.instantiate() as CardButton
		
		card_ui.custom_minimum_size = Vector2(size_x, 100)
		card_ui.iniciar(card["Name"], card["Build"])
		
		# conecta o clique
		card_ui.pressed.connect(_on_card_pressed)
		
		add_child(card_ui)

# 🎯 Quando uma carta é clicada
func _on_card_pressed():
	if not using_card:
		return
	
	var center = get_viewport().get_visible_rect().size / 2
	Input.warp_mouse(center)
	
	using_card = false
	
	# 🚫 bloqueia TODAS as cartas
	for child in get_children():
		if child is CardButton:
			child.disabled = false
