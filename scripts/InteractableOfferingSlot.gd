extends Node2D
class_name OfferingSlot

var currentItem
static var All = []

# Called when the node enters the scene tree for the first time.
func _ready():
	All.append(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interactable_zone_action_signal():
	player_try_switch_item()

func player_try_switch_item():
	play_effect()
	
func play_effect():
	var instance = preload("res://scenes/effects/offerEffect.tscn").instantiate()
	add_child(instance)

func add_item(item):
	currentItem = item
	play_effect()
	
func is_free():
	return currentItem == null
