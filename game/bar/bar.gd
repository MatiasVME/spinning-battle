extends ProgressBar

var is_pressed := false
var is_releassed := false

signal forced(force)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		is_pressed = true
		is_releassed = false
		$Timer.start()
	elif event.is_action_released("click"):
		is_releassed = true
		is_pressed = false
		
		$Timer.stop()
		forced.emit(value)
		value = 0


func _on_timer_timeout() -> void:
	if is_pressed:
		value += 25
