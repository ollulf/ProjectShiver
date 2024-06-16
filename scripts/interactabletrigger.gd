extends Area2D

class_name Interactable

const FADE_TIME = 0.25
const LABEL_UP_POSITION = 2

var isInteractable = 0
var labelOriginPosition
var tweenIn
var tweenOut

var disabled := false

signal on_interact

@onready var label = $Label

func _ready():
	labelOriginPosition = label.position
	label.modulate.a = 0

func set_disabled(value):
	disabled = value
	if value:
		Player.get_instance().change_interactable(self, false)
		if tweenIn:
			tweenIn.kill()
		$Label.modulate.a = 0
	pass

func _on_body_entered(body):
	if disabled:
		return
	
	if body is Player:
		body.change_interactable(self, true)
		isInteractable = 1
		
		tweenIn = label.create_tween()
		tweenIn.set_parallel()
		tweenIn.tween_property(label, "position", Vector2(labelOriginPosition.x, labelOriginPosition.y - LABEL_UP_POSITION), FADE_TIME)
		tweenIn.tween_property(label, "modulate:a", 1, FADE_TIME)
		label.show()

func _on_body_exited(body):
	if disabled:
		return
	
	if body is Player:
		body.change_interactable(self, false)
		isInteractable = 0

		tweenOut = label.create_tween()
		tweenOut.set_parallel()
		tweenOut.tween_property(label, "modulate:a", 0, FADE_TIME)
		tweenOut.tween_property(label, "position", Vector2(labelOriginPosition.x, labelOriginPosition.y), FADE_TIME)
			
		
func fireAction():
	on_interact.emit()
