extends StaticBody2D
class_name Shrine

static var Shrines = []
@onready var navigation_target = $navigation_target

signal itemUsedAction;
# Called when the node enters the scene tree for the first time.
func _ready():
	Shrines.append(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func npc_pray():
	var instance = preload("res://scenes/effects/offerEffect.tscn").instantiate()
	add_child(instance)

