extends Node2D

@export var duration = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.play()
	create_tween().tween_callback(queue_free).set_delay(duration)

