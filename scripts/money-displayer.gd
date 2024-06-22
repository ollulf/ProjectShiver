extends Label

@onready var animated_sprite_2d = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(MoneyHandler.currentPlayerMoney)
