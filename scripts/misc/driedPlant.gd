extends Node2D

func _on_interactable_zone_action_signal():
	var instance = preload("res://scenes/effects/poofEffect.tscn").instantiate()
	add_child(instance)
	create_tween().tween_callback(queue_free).set_delay(0.1)
	
