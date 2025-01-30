extends Sprite2D

@onready var globo = $"../globo_cat"


func _ready():
	globo.visible = false


func _process(delta):
	if get_rect().has_point(to_local(get_global_mouse_position())):
		globo.visible = true
	else:
		globo.visible = false


func _input(event):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_tree().change_scene_to_file("res://game/stage/stage.tscn")
