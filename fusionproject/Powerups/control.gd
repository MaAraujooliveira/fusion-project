extends Control
class_name Buff

@export var player : CharacterBody2D
@export var player_stats : PlayerStats

var buttons : Array

func _ready() -> void:
	buttons = get_tree().get_nodes_in_group("powerupbutton")


func mostrar_ui():
	visible = true
	get_tree().paused = true
	
	var buffs = BuffManager.pick_random_buff(3)
	
	for i in range(min(buffs.size(), buttons.size())):
		var button = buttons[i]
		var buff = buffs[i]
		
		button.text = buff["Name"]
		
		for c in button.pressed.get_connections():
			button.pressed.disconnect(c.callable)
		
		button.pressed.connect(func(): aplicar_buff(buff))
		button.mouse_entered.connect(func(): show_buff_description(buff))
		button.mouse_exited.connect(func(): show_buff_description(buff))

func show_buff_description(buff):
	$Label.text = buff["description"]

func hide_description():
	$Label.text = ""

func aplicar_buff(buff):
	buff.aplicar(player, player_stats)
	visible = false
	get_tree().paused = false
