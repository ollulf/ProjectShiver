extends PopupPanel

func close_panel():
	get_tree().paused = false
	hide()
	
func _on_close_button_pressed():
	close_panel()

# To capture "ui_cancel" pressing of Escape key
func _on_popup_hide():
	close_panel()
