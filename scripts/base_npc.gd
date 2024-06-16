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
var currentPickup

func _ready():
	taskContext = TaskContext.new(self)
	$Sprite/carry.visible = false

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
		taskQueue.append(pick_random_task())
		
	force_task(taskQueue.pop_front())

func pick_random_task():
	
	var options = []
	
	add_chance_based(options, 10, _prayTask.new())
	#add check if has money
	add_chance_based(options, 8, donateTask.new())
	
	var point = NavigationHelper.get_random_point()
	add_chance_based(options, 8, waitTask.new(point.x,point.y))
	
	add_chance_based(options, 1, poopTask.new())

	var random = options.pick_random()
	
	#var occurences = 0
	
	#for o in options:
	#	if o == random:
	#		occurences+=1
	
	#print("picked " + random.get_name() + " by chance of " + str(occurences))
	
	return random
	
func add_chance_based(options, amount, task):
	for i in amount:
		options.append(task)

func force_task(task):
	activeTask = task
	#SpeechbubbleManger.say(self, task.get_name())

func change_pickup(target, active:bool):
	if active:
		currentPickup = target
	elif currentPickup == target:
		currentPickup = null
		
	$Sprite/carry.visible = currentPickup != null

func get_pickup_parent():
	return $Sprite/carry

class TaskContext:
	@export var Delta : float
	var Npc : NPC
	
	func _init(npc):
		Npc = npc
