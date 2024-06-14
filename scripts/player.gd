extends CharacterBody2D


const SPEED = 10.0
const SMOOTHING = .1

func _physics_process(delta):
	player_movement(delta)
	
	
func player_movement(delta):
	var input = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	
	var target_velocity = Vector2(0,0)
	
	if (input):
		target_velocity = input.normalized() * SPEED
		
	velocity = lerp(velocity, target_velocity, SMOOTHING)
	
	move_and_slide()
