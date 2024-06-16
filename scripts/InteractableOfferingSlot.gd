extends Node2D
class_name OfferingSlot

@onready var navigation_target = $navigation_target

var currentPickup
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
	switch_item_with(Player.get_instance())
	
func switch_item_with(target):
	var drop = null
	if currentPickup:
		drop = currentPickup
		currentPickup.drop()
	if target.currentPickup:
		target.currentPickup.pick_up(self)
	if drop:
		drop.pick_up(target)
	
	play_effect()
	
func play_effect():
	var instance = preload("res://scenes/effects/offerEffect.tscn").instantiate()
	add_child(instance)

func is_free():
	return currentPickup == null

func change_pickup(target, active:bool):
	if active:
		currentPickup = target
	elif currentPickup == target:
		currentPickup = null
	
	if currentPickup:
		play_effect()

func get_pickup_parent():
	return self
