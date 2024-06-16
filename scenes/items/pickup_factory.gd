extends Node

var all_items := ["Apple", "Baby", "Bouquet", "Candle", "Meat", "Poop"]

func spawn_and_pick_up_random(target:Node2D):
	spawn_and_pick_up(all_items.pick_random(), target)

func spawn_and_pick_up(name:String, target:Node2D):
	
	var n = "res://scenes/items/pickup_"+ name + ".tscn"
	
	if ResourceLoader.exists(n):
		var i = load(n)
		var inst = i.instantiate()
		inst.pick_up(target)
	else:
		var tex = load("res://assets/Sprites/Item/Item-"+ name +".png")
		if tex:
			var inst = preload("res://scenes/items/pickup_base.tscn").instantiate()
			inst.set_tex(tex)
			inst.pick_up(target)
		
