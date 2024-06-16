extends Node2D

@onready var sprite = $Sprite2D
var isVisible = true
var slot
var desiredPickup

# Called when the node enters the scene tree for the first time.
func _ready():
	isVisible = false
	sprite.modulate.a = 0.0
	
	desiredPickup = PickupFactory.all_items.pick_random()

func assign_slot(slot):
	self.slot = slot
	


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

func _on_info_trigger_body_entered(body):
	if (!isVisible):
		return
		
	if (slot.currentPickup != null and slot.currentPickup.get_name() == desiredPickup):		
		SpeechbubbleManger.say(self, "thank you")
		slot.currentPickup.pick_up(self)
		queue_free()
	else:
		SpeechbubbleManger.say(self, "I want " + desiredPickup)
