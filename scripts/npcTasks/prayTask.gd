extends "res://scripts/npcTasks/npcTaskBase.gd"

class_name _prayTask

var targetShrine : Shrine
var timeSpentPraying = 0.0

func _init():
	targetShrine = Shrine.Shrines.pick_random()
	targetPositon = targetShrine.navigation_target.global_position
	
func process(context):
	if is_at_target(context):
		
		if timeSpentPraying == 0:
			targetShrine.npc_pray()
			
		timeSpentPraying += context.Delta
		
		if (timeSpentPraying > 1):
			SpeechbubbleManger.say(context.Npc, "Oh holy frog!")
			return true
	
	return false
	
func get_name():
	return "pray task"
