extends PanelContainer

var node : Node2D
var text := ""
var offset = Vector2(0,-40)

func _ready():
	position = node.get_global_transform_with_canvas().origin +offset
	$Label.text = text
	var t := create_tween()
	t.tween_property(self, "modulate:a", 1.0, 0.2).from(0)
	t.set_parallel().tween_property($Label, "visible_ratio", 1.0, float(text.length())*0.05).from(0)
	t.set_parallel(false).tween_property(self, "modulate:a", 0.0, 0.5).set_delay(float(text.length())*0.1 + 1.5)
	t.tween_callback(queue_free)

func _process(delta):
	if node:
		position = node.get_global_transform_with_canvas().origin + offset
