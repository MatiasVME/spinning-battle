extends RigidBody2D

class_name Spiner

var damage_effect_rec = preload("res://game/autoloads/damage_effect.tscn")

const INITIAL_ACEL = 0.5

var acel := INITIAL_ACEL
var speed := 100

var can_damage := false

var _colliding_bodies

var is_player := true

var last_force := 0

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
			
			if is_player and can_damage:
				#var calc_damage = int((absi(linear_velocity.x) + absi(linear_velocity.y)) * 0.05)
				var calc_damage = last_force * 0.2
				Main.enemy_hp -= calc_damage
				
				var damage_effect = damage_effect_rec.instantiate()
				damage_effect.show_damage(calc_damage)
				get_parent().add_child(damage_effect)
				damage_effect.global_position = global_position
			elif not is_player and can_damage:
				#var calc_damage = int((absi(linear_velocity.x) + absi(linear_velocity.y)) * 0.05)
				var calc_damage = last_force * 0.2
				Main.player_hp -= calc_damage
				
				var damage_effect = damage_effect_rec.instantiate()
				damage_effect.show_damage(calc_damage)
				get_parent().add_child(damage_effect)
				damage_effect.global_position = global_position
			
		$Sprite["self_modulate"] = Color.WHITE
		can_damage = false


func _on_boosted(force, is_player):
	$Sprite["self_modulate"] = Color.RED
	can_damage = true
	last_force = force


func _on_timer_timeout() -> void:
	# Si es el enemigo
	if not is_player:
		$Timer.wait_time = randf_range(2.0, 8.0)
		$Timer.start()
		
		$Sprite["self_modulate"] = Color.RED
		can_damage = true
		_on_boosted($Timer.wait_time * 250, is_player)
		#Signals.boosted.emit($Timer.wait_time * 250, is_player)
	else:
		$Timer.stop()
