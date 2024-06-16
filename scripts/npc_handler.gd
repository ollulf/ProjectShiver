extends Node2D

var npcs = []
@export var npcSpawnPosition : Vector2
@export var npcTargetCountOverTimeOfDay: Curve

const BASE_NPC = preload("res://scenes/base_npc.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var npcTargetCount = round(npcTargetCountOverTimeOfDay.sample_baked(DayNightHandler.timeOfDayInWorldHours / 24.0))
	var npcCurrentCount = npcs.size()
	
	if (npcCurrentCount < npcTargetCount):
		var newNPC = BASE_NPC.instantiate()
		newNPC.global_position = npcSpawnPosition
		npcs.append(newNPC)
		get_tree().get_first_node_in_group("level").add_child(newNPC)
		PickupFactory.spawn_and_pick_up_random(newNPC)
	elif (npcCurrentCount > npcTargetCount):
		npcs.pop_front().force_task(leaveTask.new(npcSpawnPosition.x, npcSpawnPosition.y))
	
	pass
