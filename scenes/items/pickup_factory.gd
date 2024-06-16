extends Node


func spawn_and_pick_up(name:String, target:Node2D):
	var i = load("res://scenes/items/pickup_"+ name + ".tscn")
	
	if i:
		var inst = i.instantiate()
		inst.pick_up(target)
