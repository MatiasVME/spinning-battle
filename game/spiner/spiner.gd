extends RigidBody2D

class_name Spinner

var damage_effect_rec = preload("res://game/autoloads/damage_effect.tscn")

const INITIAL_ACEL = 0.5

var ref_enemy_spinner : Spinner

var acel := INITIAL_ACEL
var speed := 100

var can_damage := false

var _colliding_bodies

var is_player := true

var last_force := 0


func _ready() -> void:
	if is_player:
		Signals.boosted.connect(_on_boosted)
	else:
		match Main.boss_selected:
			0: $Sprite.animation = "cat"
			1: $Sprite.animation = "king"
			2: $Sprite.animation = "lizard"
	
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
		if _colliding_bodies[0] is Spinner:
			acel = INITIAL_ACEL
		
		$Sprite["self_modulate"] = Color.WHITE
		can_damage = false
		_play_rand_sound_bounce()
	
	if Input.is_action_just_pressed("click"):
		$Recharge.play()
	elif Input.is_action_just_released("click"):
		$Recharge.stop()
	
	if is_player and Input.is_action_pressed("click"):
		$Sprite.scale.x = clamp($Sprite.scale.x + delta * 0.1, 0.4, 0.65)
	elif is_player and Input.is_action_just_released("click"):
		var tween = create_tween()
		tween.tween_property(
			$Sprite, 
			"scale", 
			Vector2(0.4, 0.4), 
			1.0
		).from_current().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)


func _on_boosted(force, is_player):
	$Sprite["self_modulate"] = Color.RED
	can_damage = true
	last_force = force
	impulse_to_enemy(force)


func impulse_to_enemy(force):
	if is_instance_valid(ref_enemy_spinner) and is_instance_valid(self):
		var dir = (ref_enemy_spinner.global_position - global_position).normalized()
		apply_central_impulse(dir * force)


func _play_rand_sound_hit():
	var rand_sound = $Hits.get_children()
	rand_sound[randi_range(0, rand_sound.size() - 1)].play()


func _play_rand_sound_bounce():
	var rand_sound = $Bounce.get_children()
	rand_sound[randi_range(0, rand_sound.size() - 1)].play()


func _on_timer_timeout() -> void:
	# Si es el enemigo
	if not is_player:
		$Timer.wait_time = randf_range(2.0, 6.0)
		$Timer.start()
		
		$Sprite["self_modulate"] = Color.RED
		can_damage = true
		impulse_to_enemy($Timer.wait_time * 250)
	else:
		$Timer.stop()


func _on_area_body_entered(body: Node2D) -> void:
	if body is Spinner:
		var calc_damage = last_force * 0.2
		
		if is_player and can_damage:
			Main.enemy_hp -= calc_damage
		elif not is_player and can_damage:
			calc_damage = int((absi(linear_velocity.x) + absi(linear_velocity.y)) * 0.2)
			Main.player_hp -= calc_damage
		
		if calc_damage != 0 and can_damage:
			var damage_effect = damage_effect_rec.instantiate()
			damage_effect.show_damage(calc_damage)
			get_parent().add_child(damage_effect)
			damage_effect.global_position = ref_enemy_spinner.global_position
			
			_play_rand_sound_hit()
		
		$Sprite["self_modulate"] = Color.WHITE
		can_damage = false


func _on_dead_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		queue_free()
