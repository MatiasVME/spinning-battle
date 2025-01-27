extends Control



func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://main_screens/main_menu/main_menu.tscn")
