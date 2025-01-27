extends Node2D


func _ready() -> void:
	$PlayerHP.value = $PlayerHP.max_value
	$EnemyHP.value = $EnemyHP.max_value
	
	Signals.player_hp_changed.connect(_on_player_hp_changed)
	Signals.enemy_hp_changed.connect(_on_enemy_hp_changed)


func _on_player_hp_changed(new_hp) -> void:
	$PlayerHP.value = new_hp


func _on_enemy_hp_changed(new_hp) -> void:
	$EnemyHP.value = new_hp
