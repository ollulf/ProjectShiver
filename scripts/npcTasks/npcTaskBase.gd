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
	
	var dist = abs(taskContext.Npc.global_position - targetPositon).length()
	#print("check for dist: " + str(dist))
	return 	dist < 100

func get_target():
	return targetPositon
	
func get_name():
	return "base task"
