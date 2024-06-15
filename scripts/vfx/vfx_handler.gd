extends Node


func _ready():
	create_tween().tween_callback(func():
		apply_wobble_material()
		).set_delay(0.1)

func apply_wobble_material():
	var mat = preload("res://scripts/vfx/wobble.tres")
	for x in get_tree().get_nodes_in_group("wobbly"):
		if x is Sprite2D and not x.material:
			x.material = mat
