extends Control


func win():
	$Anim.play("you_win")


func lose():
	$Anim.play("you_lose")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	Main.rechage()
	get_tree().change_scene_to_file("res://main_screens/main_menu/main_menu.tscn")
