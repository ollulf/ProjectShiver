extends "res://scripts/npcTasks/npcTaskBase.gd"
class_name offerTask

var targetSlot : OfferingSlot
var timeSpentOffering = 0.0

func _init():
	var filtered = OfferingSlot.All.filter(func(o): return o.is_free())
	if filtered.size() > 0:
		targetSlot = filtered.pick_random()
	else:
		targetSlot = OfferingSlot.All.pick_random()
		
	targetPositon = targetSlot.navigation_target.global_position
	
func process(context):
	if is_at_target(context):
		
		if timeSpentOffering == 0:
			if (targetSlot.is_free()):
				targetSlot.switch_item_with(context.Npc)
			else:
				targetSlot.play_effect()
			
		timeSpentOffering += context.Delta
		
		if (timeSpentOffering > 1):
			return true
	
	return false
	
func get_name():
	return "pray task"
