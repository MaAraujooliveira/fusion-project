extends Node

@export var buffs = [
	preload("res://Powerups/Powers/Recourses/Damage/damage.tres"),
	preload("res://Powerups/Powers/Recourses/BulletQtd/bullet_qtd.tres"),
	preload("res://Powerups/Powers/Recourses/Cards_qtd/cards_qtd.tres")
]

func pick_random_buff(qtd: int) -> Array:
	var resultado := []
	
	for i in range(qtd):
		resultado.append(buffs.pick_random())
	
	return resultado
