extends Sprite2D

enum AnimState { IDLE, WALK }

var current_anim_state = AnimState.WALK
var xOrientation = 1;

@export var direction : Vector2 = Vector2(0,0);

const SQUASH_STRENGTH = 0.05
const IDLE_ANIMATION_SPEED = 3
const IDLE_PEAK_SHARPNESS = 4
const WALK_ANIMATION_SPEED = 20.0
const WALK_ROTATION_STRENGTH = .3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var timeInSeconds = Time.get_ticks_msec() / 1000.0
	var scaleOffset = sin(timeInSeconds * IDLE_ANIMATION_SPEED)
	var scaleBase = pow(abs(scaleOffset), IDLE_PEAK_SHARPNESS) * SQUASH_STRENGTH
	var xScale = 1 + abs(scaleBase - SQUASH_STRENGTH)
	var yScale =  1 + scaleBase
	
	var rotationTarget = 0.0;
	
	if direction.length() > 0:
		var t = timeInSeconds * WALK_ANIMATION_SPEED
		var raw = pow(abs(sin(t)), .2) * sign(sin(t))
		rotationTarget = raw * WALK_ROTATION_STRENGTH
		
		var rawS = pow(abs(sin(t)), .4) * sign(sin(t))
		
		scaleBase = abs(rawS) * SQUASH_STRENGTH
		xScale =  1 + scaleBase
		yScale = 1 + abs(scaleBase - SQUASH_STRENGTH)
		
		position = Vector2(0, 2 - abs(rawS) * 4)
		
		if (direction.x):
			xOrientation = sign(direction.x)
	else:
		position = Vector2.ZERO
		
	rotation = lerp(rotation, rotationTarget, .1)
	scale = Vector2(xScale * xOrientation, yScale)
