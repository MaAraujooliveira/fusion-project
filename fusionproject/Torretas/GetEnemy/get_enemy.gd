extends Node
class_name EnemyFinder

@export var turret : Node2D
@export var turret_stats : TurretStats

func find_target() -> Node2D:
	var enemys = get_tree().get_nodes_in_group("Enemy")
	var closest : Node2D = null
	var closest_distance := INF
	
	for enemy in enemys:
		var dist = turret.global_position.distance_to(enemy.global_position)
		
		if dist <= turret_stats.range and dist < closest_distance:
			closest_distance = dist
			closest = enemy
	
	return closest
