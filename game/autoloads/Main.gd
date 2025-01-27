extends Node


var player_hp := 1000:
	set(value):
		player_hp = value
		Signals.player_hp_changed.emit(value)
		
var enemy_hp = 1000:
	set(value):
		enemy_hp = value
		Signals.enemy_hp_changed.emit(value)
