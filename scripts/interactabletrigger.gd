extends Area2D

var isInteractable = 0
@onready var label = $Label

func _ready():
	$Label.hide()

func _on_body_entered(body):
	isInteractable = 1
	$Label.show()


func _on_body_exited(body):
	isInteractable = 0
	$Label.hide()
