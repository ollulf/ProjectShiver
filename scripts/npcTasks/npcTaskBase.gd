extends Object

class_name npcTaskBase

var startTime = null
@export var targetPositon : Vector2

func _init(x, y):
	targetPositon = Vector2(x,y)

func process(delta):
	if startTime == null:
		startTime = Time.get_ticks_msec()
	elif startTime + 2000.0 < Time.get_ticks_msec():
		return true
	
	return false
	
func is_at_target(taskContext):
	return 	(taskContext.Npc.global_position - targetPositon).length() < 0.25

func get_target():
	return targetPositon
