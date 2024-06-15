extends Area2D

class_name Interactable

var isInteractable = 0
signal action_signal()

@onready var label = $Label

func _ready():
	$Label.hide()

func _on_body_entered(body):
	if body is Player:
		(body as Player).change_interactable(self)
		isInteractable = 1
		$Label.show()

func _on_body_exited(body):
	if body is Player:
		(body as Player).change_interactable(null)
		isInteractable = 0
		$Label.hide()
		
func _fireAction():
	print("emit signal!")
	action_signal.emit()
