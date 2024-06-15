extends "res://scripts/npcTasks/npcTaskBase.gd"

class_name leaveTask

func process(context):
	
	if is_at_target(context):
		context.Npc.queue_free()
		context.Npc.destroyed = true
		print("destroyed npc")
	
	return false
