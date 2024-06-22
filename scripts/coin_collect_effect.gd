extends AnimatedSprite2D

var target_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	target_position = global_position + Vector2(160, -70)
	scale = Vector2.ZERO
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "scale", Vector2(1,1), .2).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(self, "global_position", target_position, 1).set_trans(Tween.TRANS_SINE).set_delay(.1)
	tween.parallel().tween_property(self, "scale", Vector2.ZERO, .25).set_delay(.75);
	tween.tween_callback(queue_free)
