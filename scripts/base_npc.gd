extends CharacterBody2D

@onready var navigation = $NavigationAgent2D
@onready var sprite = $Sprite

const SPEED = 30.0
const ACCELLERATION = 7.0

func _physics_process(delta):

	var direction = Vector2()
	
	navigation.target_position = get_global_mouse_position()
	
	direction = (navigation.get_next_path_position() - global_position).normalized()
	sprite.direction = direction
	
	velocity = lerp(velocity, direction * SPEED, delta * ACCELLERATION)
	
	
	
	move_and_slide()
