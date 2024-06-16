extends "res://scripts/npcTasks/npcTaskBase.gd"

class_name donateTask

var targetBowl : DonationBowl

func _init():
	targetBowl = DonationBowl.Bowls.pick_random()
	targetPositon = targetBowl.navigation_target.global_position
	
func process(context):
	if is_at_target(context):
		targetBowl.add_money(int(randf_range(1,4)))
		SpeechbubbleManger.say(context.Npc, "For my sins!")
		return true
	
	return false
	
func get_name():
	return "donate task"
