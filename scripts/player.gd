extends CharacterBody2D

class_name Player

const WALK_SPEED = 50.0
const SMOOTHING = .1
var currentInteractable
var currentPickup

var quack_sprite1 = load("res://assets/Sprites/Characters/Main-Frog-QUACK-1.png")
var quack_sprite2 = load("res://assets/Sprites/Characters/Main-Frog-QUACK-2.png")
var default_sprite
static var instance

@onready var sprite = $sprite
@onready var audio_stream_player = $AudioStreamPlayer

func _init():
	instance = self

func _ready():
	$sprite/carry.visible = false
	
	default_sprite = sprite.texture

func _exit_tree():
	instance = null

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var target_velocity = Vector2(0,0)
	
	if Input.is_action_just_pressed("ui_accept"):
		perform_action()
		
	if Input.is_action_just_pressed("quack"):
		quack()
	
	if Input.is_key_pressed(KEY_4):
		SpeechbubbleManger.say(self, "Hello!")
	
	if Input.is_key_pressed(KEY_5) and not currentPickup:
		PickupFactory.spawn_and_pick_up_random(self)
	
	if (input):
		target_velocity = input.normalized() * WALK_SPEED
		sprite.direction = input.normalized()
	else:
		sprite.direction = Vector2.ZERO
		
	velocity = lerp(velocity, target_velocity, SMOOTHING)
	
	move_and_slide()
	
func perform_action():
	if currentInteractable:
		currentInteractable.fireAction()
	elif currentPickup:
		currentPickup.drop()
		
func change_interactable(target, active:bool):
	if active:
		currentInteractable = target
	elif currentInteractable == target:
		currentInteractable = null

func change_pickup(target, active:bool):
	if active:
		if currentPickup:
			currentPickup.drop()
		currentPickup = target
	elif currentPickup == target:
		currentPickup = null
		
	$sprite/carry.visible = currentPickup != null

func get_pickup_parent():
	return $sprite/carry

static func get_instance():
	return instance
	
func quack():
	audio_stream_player.play()
	
	sprite.texture = quack_sprite1 
	await get_tree().create_timer(0.1).timeout
	sprite.texture = quack_sprite2 
	await get_tree().create_timer(0.1).timeout
	sprite.texture = quack_sprite1 
	await get_tree().create_timer(0.1).timeout
	sprite.texture = default_sprite 
	return
