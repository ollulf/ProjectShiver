extends CharacterBody2D


const WALK_SPEED = 50.0
const SMOOTHING = .1

@onready var sprite = $sprite

func _physics_process(delta):
	player_movement(delta)
	
	
func player_movement(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var target_velocity = Vector2(0,0)
	
	if (input):
		target_velocity = input.normalized() * WALK_SPEED
		sprite.direction = input.normalized()
	else:
		sprite.direction = Vector2.ZERO
		
	velocity = lerp(velocity, target_velocity, SMOOTHING)
	
	move_and_slide()
