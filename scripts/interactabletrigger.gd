extends Area2D

class_name Interactable

const FADE_TIME = 0.25
const LABEL_UP_POSITION = 2

var isInteractable = 0
var labelOriginPosition
var tweenIn
var tweenOut

var is_being_destroyed = false

var disabled := false

signal on_interact

#this is for money or faith checks
@export var money_needed_for_interaction = 0

@onready var label = $Label

func _ready():
	labelOriginPosition = label.position
	label.modulate.a = 0
	
	if money_needed_for_interaction != 0:
		$Label/Label2.text = "Gold" + str(money_needed_for_interaction)
		
	else: 
		$Label/Label2.text = ""
	

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

		if is_inside_tree() and not is_being_destroyed:
			tweenOut = label.create_tween()
			if tweenOut:
				tweenOut.set_parallel()
				tweenOut.tween_property(label, "modulate:a", 0, FADE_TIME)
				tweenOut.tween_property(label, "position", Vector2(labelOriginPosition.x, labelOriginPosition.y), FADE_TIME)
				
func _exit_tree():
	is_being_destroyed = true

func _on_tree_exited():
	is_being_destroyed = true

func fireAction():
	if MoneyHandler.currentPlayerMoney >= money_needed_for_interaction:
		MoneyHandler.UpdateMoney(MoneyHandler.currentPlayerMoney - money_needed_for_interaction)
		on_interact.emit()
