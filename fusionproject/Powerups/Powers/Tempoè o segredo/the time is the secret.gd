extends BasePower
class_name TempoePoder

func aplicar(player: Player, player_stats: PlayerStats):
	player.weakpons.cooldown = clamp(player.weakpons.cooldown * 0.8, 0.05, 999)
	player_stats.speed = clamp(player_stats.speed * 0.8, 50, 999)
