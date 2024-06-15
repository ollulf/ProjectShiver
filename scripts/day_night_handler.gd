class_name Day_night_handler

extends DirectionalLight2D

@export var darknessOverTimeOfDay: Curve
@export var WORLD_HOUR_DURATION_IN_REAL_SECONDS = 30.0;

@export var timeOfDayInWorldHours = 10.0
var day = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# update time of day
	timeOfDayInWorldHours += delta / WORLD_HOUR_DURATION_IN_REAL_SECONDS
	
	# update brightness
	energy = darknessOverTimeOfDay.sample_baked(timeOfDayInWorldHours / 24.0);
	pass
