extends "res://scripts/npcTasks/npcTaskBase.gd"

class_name poopTask

var timeSpentPooping = 0.0

func _init():
	targetPositon = NavigationHelper.get_random_point()

func process(context):
	if is_at_target(context):
		
		if timeSpentPooping == 0:
			SpeechbubbleManger.say(context.Npc, "It's coming!")
			
		timeSpentPooping += context.Delta
		
		if (timeSpentPooping > 1):
			PickupFactory.spawn_and_place("Poop", context.Npc.global_position)
			return true
	
	return false
	
func get_name():
	return "poop task"
