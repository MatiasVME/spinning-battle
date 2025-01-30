extends Control


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start":
		Signals.started.emit()
