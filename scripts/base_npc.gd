extends CharacterBody2D
class_name NPC

@onready var navigation = $NavigationAgent2D
@onready var sprite = $Sprite

const SPEED = 30.0
const ACCELLERATION = 7.0

var taskQueue = []
var activeTask;
var taskContext;

var destroyed = false

func _ready():
	taskContext = TaskContext.new(self)

func _physics_process(delta):

	if destroyed:
		return

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
	
	if destroyed:
		return
	
	taskContext.Delta = delta
	
	if activeTask != null:
		if activeTask.process(taskContext):
			activeTask = null
		else:
			return
			
	if taskQueue.size() == 0:
		
		var rng = RandomNumberGenerator.new()
		
		if rng.randf() < 0.1:
			SpeechbubbleManger.say(self, "Croak")
		
		if rng.randf() < 0.5:
			taskQueue.append(npcTaskBase.new(12,12))
		else:
			taskQueue.append(npcTaskBase.new(-7,-7))
		
	force_task(taskQueue.pop_front())
	
func force_task(task):
	#print("force task: " + str(task))
	activeTask = task
	
class TaskContext:
	@export var Delta : float
	var Npc : NPC
	
	func _init(npc):
		Npc = npc
