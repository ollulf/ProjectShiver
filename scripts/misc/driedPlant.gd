extends Node2D

func _on_interactable_zone_on_interact():
	var instance = preload("res://scenes/effects/poofEffect.tscn").instantiate()
	add_sibling(instance)
	instance.position = position
	create_tween().tween_callback(queue_free).set_delay(0.1)# Replace with function body.
