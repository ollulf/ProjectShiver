extends CharacterBody2D

class_name Player

const WALK_SPEED = 50.0
const SMOOTHING = .1
var currentInteractable

@onready var sprite = $sprite

func _physics_process(delta):
	player_movement(delta)
	
	
func player_movement(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var target_velocity = Vector2(0,0)
	
	if Input.is_action_just_pressed("ui_accept"):
		perform_action()
	
	if Input.is_key_pressed(KEY_O):
		SpeechbubbleManger.say(self, "Hello!")
	
	if (input):
		target_velocity = input.normalized() * WALK_SPEED
		sprite.direction = input.normalized()
	else:
		sprite.direction = Vector2.ZERO
		
	velocity = lerp(velocity, target_velocity, SMOOTHING)
	
	move_and_slide()
	
func perform_action():
	
	print ("E")
	if currentInteractable != null:
		(currentInteractable as Interactable)._fireAction()
	else:
		print("interactablezone is null")
		
func change_interactable(InteractableZone):
		currentInteractable = InteractableZone
		print(InteractableZone)
