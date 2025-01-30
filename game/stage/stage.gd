extends Node2D

var spiner = preload("res://game/spiner/spiner.tscn")

var player_spiner : Spinner
var boss_spiner : Spinner


func _ready() -> void:
	Signals.started.connect(_on_started)


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


func _on_started():
	create_player_spiner()
	create_boss_spiner()
	
	player_spiner.ref_enemy_spinner = boss_spiner
	boss_spiner.ref_enemy_spinner = player_spiner
	
	Signals.player_dead.connect(_on_player_dead)
	Signals.enemy_dead.connect(_on_enemy_dead)


func _on_player_dead():
	player_spiner.queue_free()
	
	$EndLevel.lose()


func _on_enemy_dead():
	boss_spiner.queue_free()
	
	$EndLevel.win()
	
