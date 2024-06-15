extends CharacterBody2D
class_name NPC

@onready var navigation = $NavigationAgent2D
@onready var sprite = $Sprite

const SPEED = 30.0
const ACCELLERATION = 7.0

var taskQueue = []
var activeTask;
var taskContext;

func _ready():
	taskContext = TaskContext.new(self)

func _physics_process(delta):

	if activeTask == null:
		return

	var direction = Vector2()
	
	if (!activeTask.is_at_target(taskContext)):
		navigation.target_position = activeTask.get_target()
	
		direction = (navigation.get_next_path_position() - global_position).normalized()
		
	sprite.direction = direction
	velocity = lerp(velocity, direction * SPEED, delta * ACCELLERATION)
		
	move_and_slide()

func _process(delta):
	
	taskContext.Delta = delta
	
	if activeTask != null:
		if activeTask.process(taskContext):
			activeTask = null
		else:
			return
			
	if taskQueue.size() == 0:
		
		var rng = RandomNumberGenerator.new()
		
		if rng.randf() < 0.5:
			print("append new wait task")
			taskQueue.append(npcTaskBase.new(12,12))
		else:
			print("append new base task")
			taskQueue.append(npcTaskBase.new(-7,-7))
		
	activeTask = taskQueue.pop_front()
	
class TaskContext:
	@export var Delta : float
	var Npc : NPC
	
	func _init(npc):
		Npc = npc
		
