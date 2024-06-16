extends "res://scripts/npcTasks/npcTaskBase.gd"

class_name donateTask

var targetBowl : DonationBowl

func _init():
	targetBowl = DonationBowl.Bowls.pick_random()
	targetPositon = targetBowl.global_position
	
func process(context):
	if is_at_target(context):
		targetBowl._changeMoney(targetBowl.currentMoney + randf_range(1,3))
		print("donate")
		return true
	
	return false
	
	
func get_name():
	return "donate task"
