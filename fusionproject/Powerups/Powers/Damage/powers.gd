extends BasePower
class_name DamagePower

func aplicar(player,player_stats:PlayerStats):
	player_stats.damage += buff
	player_stats.speed = clamp(player_stats.speed + 100, 50, 3500)
