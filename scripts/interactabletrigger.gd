extends Area2D

class_name Interactable

const FADE_TIME = 0.25
const LABEL_UP_POSITION = 2

var isInteractable = 0
var labelOriginPosition
var tweenIn
var tweenOut

signal action_signal()

@onready var label = $Label

func _ready():
	labelOriginPosition = label.position
	label.modulate.a = 0

func _on_body_entered(body):
	if body is Player:
		(body as Player).change_interactable(self)
		isInteractable = 1
		
		tweenIn = label.create_tween()
		tweenIn.set_parallel()
		tweenIn.tween_property(label, "position", Vector2(labelOriginPosition.x, labelOriginPosition.y - LABEL_UP_POSITION), FADE_TIME)
		tweenIn.tween_property(label, "modulate:a", 1, FADE_TIME)
		label.show()

func _on_body_exited(body):
	if body is Player:
		(body as Player).change_interactable(null)
		isInteractable = 0

		tweenOut = label.create_tween()
		tweenOut.set_parallel()
		tweenOut.tween_property(label, "modulate:a", 0, FADE_TIME)
		tweenOut.tween_property(label, "position", Vector2(labelOriginPosition.x, labelOriginPosition.y), FADE_TIME)
		
func _fireAction():
	print("emit signal!")
	action_signal.emit()
