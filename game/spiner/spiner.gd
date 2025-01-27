extends RigidBody2D

class_name Spiner

const INITIAL_ACEL = 0.5

var acel := INITIAL_ACEL
var speed := 100

var can_damage := false

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
			
			if is_player:
				var calc_damage = int((absi(linear_velocity.x) + absi(linear_velocity.y)) * 0.05)
				Main.enemy_hp -= calc_damage
				$Damage.text = str(calc_damage)
				print("enemy - ", int((absi(linear_velocity.x) + absi(linear_velocity.y)) * 0.05))
			else:
				var calc_damage = int((absi(linear_velocity.x) + absi(linear_velocity.y)) * 0.05)
				Main.player_hp -= calc_damage
				$Damage.text = str(calc_damage)
				print("player - ", calc_damage)
			
		$Sprite["self_modulate"] = Color.WHITE
		can_damage = false


func _on_boosted(force, is_player):
	$Sprite["self_modulate"] = Color.RED
	can_damage = true


func _on_timer_timeout() -> void:
	if not is_player:
		$Timer.wait_time = randf_range(2.0, 8.0)
		$Timer.start()
		
		$Sprite["self_modulate"] = Color.RED
		can_damage = true
		Signals.boosted.emit($Timer.wait_time * 250, is_player)
	else:
		$Timer.stop()
