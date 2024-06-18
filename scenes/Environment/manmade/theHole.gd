extends StaticBody2D

func _on_interactable_zone_on_interact():
	var temp = Player.get_instance().currentPickup
	
	if temp:
		temp.destroy()
		
