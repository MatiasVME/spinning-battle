extends RigidBody2D

class_name Spiner

const INITIAL_ACEL = 0.5

var acel := INITIAL_ACEL
var speed := 100

var _colliding_bodies

var is_player := true

func _ready() -> void:
	if is_player:
		Signals.boosted.connect(_on_boosted)
	
	apply_central_impulse(Vector2(randi_range(-500, 500), randi_range(-500, 500)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	acel += delta * 10
	$Sprite.rotation_degrees += clamp(
		delta * speed + acel,
		0.5, 
		50
	)
	
	_colliding_bodies = get_colliding_bodies()
	if _colliding_bodies.size() > 0:
		if _colliding_bodies[0] is Spiner:
			acel = INITIAL_ACEL
			#apply_central_impulse(Vector2(randi_range(-50, 50), randi_range(-50, 50)))
			#$AnimHit.play("hit")
		$Sprite["self_modulate"] = Color.WHITE


func _on_boosted(force, is_player):
	$Sprite["self_modulate"] = Color.RED


func _on_timer_timeout() -> void:
	if not is_player:
		$Timer.wait_time = randf_range(2.0, 8.0)
		$Timer.start()
		
		$Sprite["self_modulate"] = Color.RED
		Signals.boosted.emit($Timer.wait_time * 250, is_player)
	else:
		$Timer.stop()
