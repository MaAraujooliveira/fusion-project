extends HBoxContainer
class_name Cards_manager

@export var size_x := 200
@export var cards_ui_scene : PackedScene
@export var stats : PlayerStats
@export var frame : GraphFrame

var using_card := false
var cards_dic = CardsDictionary.cards
var cards := 0
var max_cards := 7


func _ready() -> void:
	var style = frame.get_theme_stylebox("panel")
	
	if style is StyleBoxFlat:
		style.bg_color = Color(0.08, 0.08, 0.1) # sua cor nova

func pick_random_cards(chose_stats:bool):
	if cards >= max_cards:
		return []
	
	var picked_cards := []
	var qtd
	if chose_stats:
		qtd = min(stats.picked_qtd, max_cards - cards)
	else:
		qtd = 1
	
	for i in range(qtd):
		var key = cards_dic.keys().pick_random()
		var card = cards_dic[key]
		
		picked_cards.append(card)
		cards += 1
	
	return picked_cards

# 🎯 Cria as cartas na tela
func add_to_ui(chose_based_by_stats:bool):
	if cards >= max_cards:
		return 
	
	var picked = pick_random_cards(chose_based_by_stats)
	
	if picked.is_empty():
		return
	
	using_card = true
	
	for card in picked:
		var card_ui = cards_ui_scene.instantiate() as CardButton
		card_ui.custom_minimum_size = Vector2(size_x, 100)
		card_ui.iniciar(card["Name"], card["Build"],self)
		
		card_ui.pressed.connect(_on_card_pressed)
		
		add_child(card_ui)

# 🎯 Quando uma carta é clicada
func _on_card_pressed():
	if not using_card:
		return
	
	if cards > 0:
		cards -= 1
	
	using_card = false
