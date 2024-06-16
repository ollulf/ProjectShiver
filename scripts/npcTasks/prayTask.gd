extends "res://scripts/npcTasks/npcTaskBase.gd"

class_name prayTask

var targetShrine : Shrine

func _init():
	targetShrine = Shrine.Shrines.pick_random()
	targetPositon = targetShrine.navigation_target.global_position
	
func process(context):
	if is_at_target(context):
		targetShrine.npc_pray()
		print("donate")
		return true
	
	return false
	
func get_name():
	return "pray task"
