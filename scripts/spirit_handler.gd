extends Node2D

var Spririts = []
var slotSpiritDict = {}

const BASE_SPIRIT = preload("res://scenes/spirit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var spiritTargetCount = Shrine.Shrines.size()
	var spiritCurrentCount = Spririts.size()
	
	if (spiritCurrentCount < spiritTargetCount):
		
		var randomSlot = OfferingSlot.All.pick_random()
			
		if !slotSpiritDict.has(randomSlot):
		
			var newSpirit = BASE_SPIRIT.instantiate()
			newSpirit.global_position = randomSlot.global_position
			slotSpiritDict[randomSlot] = newSpirit
			Spririts.append(newSpirit)
			add_child(newSpirit)
