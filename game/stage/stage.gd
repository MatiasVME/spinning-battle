extends Node2D

var player_spiner = preload("res://game/spiner/spiner.tscn").instantiate()
var boss_spiner = preload("res://game/spiner/spiner.tscn").instantiate()


func _ready() -> void:
	Signals.started.connect(_on_started)


func create_player_spiner():
	player_spiner.global_position = Vector2(randi_range(150, 1150), randi_range(150, 675))
	add_child(player_spiner)


func create_boss_spiner():
	boss_spiner.global_position = Vector2(randi_range(150, 1150), randi_range(150, 675))
	boss_spiner.is_player = false
	
	boss_spiner.get_node("Sprite").animation = "cat"
	
	add_child(boss_spiner)


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


func _on_ready() -> void:
	match Main.boss_selected:
		0:
			$Floor.animation = "cat_stage"
			$Hud/AvatarEnemy.animation = "cat"
		1:
			$Floor.animation = "king_stage"
			$Hud/AvatarEnemy.animation = "king"
		2:
			$Floor.animation = "lizard_stage"
			$Hud/AvatarEnemy.animation = "lizard"
