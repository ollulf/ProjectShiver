extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time = DayNightHandler.timeOfDayInWorldHours;
	var minutes =  fmod(time, 1.0) * 60
	var hours = int(time)
	
	text = "%02d:%02d" % [hours, minutes]
