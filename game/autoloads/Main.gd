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

var is_cat_defeated := false
var is_king_defeated := false
var is_lizard_defeated := false

var boss_selected := -1 # 0 cat | 1 king | 2 lizard

func rechage():
	player_hp = 1000
	enemy_hp = 1000
