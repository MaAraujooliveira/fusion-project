extends Node

@export var buffs = [
	preload("res://Powerups/Powers/Recourses/Damage/damage.tres"),
]

func pick_random_buff(qtd: int) -> Array:
	var resultado := []
	
	for i in range(qtd):
		resultado.append(buffs.pick_random())
	
	return resultado
