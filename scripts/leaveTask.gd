extends "res://scripts/npcTasks/npcTaskBase.gd"

class_name leaveTask

func process(context):
	if is_at_target(context):
		context.NPC.queue_free()
	
	return false
