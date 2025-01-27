extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerHP.value = $PlayerHP.max_value
	$EnemyHP.value = $EnemyHP.max_value
