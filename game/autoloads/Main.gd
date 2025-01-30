extends Node


var player_hp := 1000:
	set(value):
		player_hp = value
		
		if player_hp >= 0:
			Signals.player_hp_changed.emit(value)
		else:
			Signals.player_dead.emit()

var enemy_hp := 1000:
	set(value):
		enemy_hp = value
		
		if enemy_hp >= 0:
			Signals.enemy_hp_changed.emit(value)
		else:
			Signals.enemy_dead.emit()


func rechage():
	player_hp = 1000
	enemy_hp = 1000
