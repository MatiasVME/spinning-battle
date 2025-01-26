extends RigidBody2D

class_name Spiner

const INITIAL_ACEL = 0.5

var acel := INITIAL_ACEL
var speed := 100

var _colliding_bodies

func _ready() -> void:
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
		acel = INITIAL_ACEL
		#apply_central_impulse(Vector2(randi_range(-50, 50), randi_range(-50, 50)))
		$AnimHit.play("hit")
		
