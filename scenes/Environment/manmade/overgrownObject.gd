extends StaticBody2D
@export var normalObject = preload("res://scenes/environment/manmade/shrine.tscn")

func _convertObject():
	var instance = normalObject.instantiate()
	add_sibling(instance)
	instance = preload("res://scenes/effects/poofEffect.tscn").instantiate()
	add_sibling(instance)


func _on_interactable_zone_on_interact():
	_convertObject()
