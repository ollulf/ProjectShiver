extends Node2D

var picked_up := false
var holder

func _ready():
	$interactableZone.on_interact.connect(onInteract)
	
func onInteract():
	if picked_up:
		drop()
	else:
		pick_up(get_tree().get_first_node_in_group("player"))
	

func pick_up(target:Node2D):
	if picked_up:
		drop()	

	holder = target
	if holder.has_method("change_pickup"):
		holder.change_pickup(self,true)
	picked_up = true
	$interactableZone.set_disabled(true)
	var p = global_position
	if get_parent():
		get_parent().remove_child(self)
	
	var parent = target
	if target.has_method("get_pickup_parent"):
		parent = target.get_pickup_parent()
	parent.add_child(self)
	
	position = Vector2.ZERO
	
func drop():
	if holder.has_method("change_pickup"):
		holder.change_pickup(self,false)
	picked_up = false
	var root = get_tree().get_first_node_in_group("level")
	var p = global_position
	get_parent().remove_child(self)
	root.add_child(self)
	global_position = p
	$interactableZone.set_disabled(false)
