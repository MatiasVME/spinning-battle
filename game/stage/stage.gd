extends Node2D

var spiner = preload("res://game/spiner/spiner.tscn")

var player_spiner : Spiner
var boss_spiner : Spiner


func _ready() -> void:
	create_player_spiner()
	create_boss_spiner()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var dir = (boss_spiner.global_position - player_spiner.global_position).normalized()
		player_spiner.apply_central_impulse(dir * 1000)


func create_player_spiner():
	var spiner_inst = spiner.instantiate()
	spiner_inst.global_position = Vector2(randi_range(150, 1150), randi_range(150, 675))
	player_spiner = spiner_inst
	add_child(spiner_inst)


func create_boss_spiner():
	var spiner_inst = spiner.instantiate()
	spiner_inst.global_position = Vector2(randi_range(150, 1150), randi_range(150, 675))
	boss_spiner = spiner_inst
	
	boss_spiner.get_node("Sprite").animation = "cat"
	
	add_child(spiner_inst)
