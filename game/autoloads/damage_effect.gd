extends Node2D


func show_damage(damage: int) -> void:
	$Damage.text = str(damage)


func _on_timer_timeout() -> void:
	queue_free()
