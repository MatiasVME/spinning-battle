extends Node2D

var spiner = preload("res://game/spiner/spiner.tscn")

var player_spiner : Spiner
var boss_spiner : Spiner


func _ready() -> void:
	Signals.boosted.connect(_on_boosted)
	
	create_player_spiner()
	create_boss_spiner()


func create_player_spiner():
	var spiner_inst = spiner.instantiate()
	spiner_inst.global_position = Vector2(randi_range(150, 1150), randi_range(150, 675))
	player_spiner = spiner_inst
	add_child(spiner_inst)


func create_boss_spiner():
	var spiner_inst = spiner.instantiate()
	spiner_inst.global_position = Vector2(randi_range(150, 1150), randi_range(150, 675))
	boss_spiner = spiner_inst
	boss_spiner.is_player = false
	
	boss_spiner.get_node("Sprite").animation = "cat"
	
	add_child(spiner_inst)


func _on_boosted(force, is_player):
	if is_player:
		var dir = (boss_spiner.global_position - player_spiner.global_position).normalized()
		player_spiner.apply_central_impulse(dir * force)
	else:
		var dir = (player_spiner.global_position - boss_spiner.global_position).normalized()
		boss_spiner.apply_central_impulse(dir * force)
