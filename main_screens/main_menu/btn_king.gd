extends TextureButton

@onready var globo = $"../globo_michumucha"


func _ready():
	globo.visible = false


func _on_mouse_entered() -> void:
	globo.visible = true


func _on_mouse_exited() -> void:
	globo.visible = false


func _on_pressed() -> void:
	Main.boss_selected = 1
	get_tree().change_scene_to_file("res://game/stage/stage.tscn")
