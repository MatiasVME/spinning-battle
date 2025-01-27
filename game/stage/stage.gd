extends Node2D

var spiner = preload("res://game/spiner/spiner.tscn")

var player_spiner : Spinner
var boss_spiner : Spinner


func _ready() -> void:
	create_player_spiner()
	create_boss_spiner()
	
	player_spiner.ref_enemy_spinner = boss_spiner
	boss_spiner.ref_enemy_spinner = player_spiner


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
