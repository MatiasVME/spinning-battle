extends Control


func _ready() -> void:
	if Main.is_cat_defeated:
		$btn_cat.hide()
	if Main.is_king_defeated:
		$btn_king.hide()
	if Main.is_lizard_defeated:
		$btn_lagarto.hide()
