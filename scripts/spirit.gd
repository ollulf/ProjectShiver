extends Node2D

@onready var sprite = $Sprite2D
var isVisible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var time = DayNightHandler.timeOfDayInWorldHours
	var shouldBeVisible = time > 22 or time < 5
	
	if isVisible == shouldBeVisible:
		return
		
	isVisible = shouldBeVisible
		
	print(shouldBeVisible)
	
	var tween = create_tween()
	if shouldBeVisible:
		tween.tween_property(sprite, "modulate:a", 1.0, 1.0)
	else:
		tween.tween_property(sprite, "modulate:a", 0.0, 1.0)
