extends CanvasLayer

const SPEECHBUBBLE = preload("res://scenes/speechbubble.tscn")

func say(node:Node2D, text:String) -> float:
	var new_bubble := SPEECHBUBBLE.instantiate()
	new_bubble.text = text
	new_bubble.node = node
	add_child(new_bubble)
	
	return float(text.length())*0.05 + 1
