extends StaticBody2D

func _on_interactable_zone_on_interact():
	var temp = Player.get_instance().currentPickup
	
	if temp:
		#Play Animation of destroyed item
		
		$Sprite2D2.texture = temp.get_tex()
		$AnimationPlayer.play("theHole")
		
		temp.destroy()
		
		var tween = create_tween()
		tween.tween_interval(0.5) 
		tween.tween_callback(Callable(self, "_on_item_in_hole"))
		

func _on_item_in_hole():
	$Sprite2D2.texture = null
	
	var instance = preload("res://scenes/effects/holeEffect.tscn").instantiate()
	add_sibling(instance)
	instance.position = position + Vector2(-6,26)
