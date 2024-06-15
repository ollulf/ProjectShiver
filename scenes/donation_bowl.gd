extends Sprite2D

var donationLimit = 30
var currentMoney = 15

func _changeMoney(amount):
	currentMoney += amount

func _on_interactable_zone_action_signal():

	if currentMoney > 0:
		_changeMoney(-currentMoney)
		print("retract", currentMoney)
		# + give player money
	else:
		print("no money available")
