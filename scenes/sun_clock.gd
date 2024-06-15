extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var min = 0
	var max = hframes
	
	frame = lerp(min, max, (fmod(DayNightHandler.timeOfDayInWorldHours + 6.0, 12.0) / 12.0))
