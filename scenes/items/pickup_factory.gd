extends Node

var all_items := ["Apple", "Baby", "Bouquet", "Candle", "Meat", "Poop"]

func spawn_and_pick_up_random(target:Node2D):
	spawn_and_pick_up(all_items.pick_random(), target)

func spawn_and_pick_up(name:String, target:Node2D):
	
	var inst = spawn_base(name)
	inst.pick_up(target)
		
func spawn_and_place(name:String, target:Vector2):
	var inst = spawn_base(name)
	inst.global_position = target
	var root = get_tree().get_first_node_in_group("level")
	var p = target
	root.add_child(inst)

func spawn_base(name:String):
	
	var inst
	
	var n = "res://scenes/items/pickup_"+ name + ".tscn"
	
	if ResourceLoader.exists(n):
		var i = load(n)
		inst = i.instantiate()
	else:
		var tex = load("res://assets/Sprites/Item/Item-"+ name +".png")
		if tex:
			inst = preload("res://scenes/items/pickup_base.tscn").instantiate()
			inst.set_tex(tex)
	
	inst.set_name(name)
	
	return inst
