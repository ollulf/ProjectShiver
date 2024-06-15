extends Sprite2D

var donationLimit = 30
var currentMoney = 15

func _changeMoney(amount):
	currentMoney += amount
	
	if currentMoney > donationLimit:
		currentMoney = donationLimit

func _on_interactable_zone_action_signal():

	if currentMoney > 0:
		MoneyHandler.UpdateMoney(currentMoney)
		_changeMoney(-currentMoney)
		print("retract", currentMoney)
		
	else:
		print("no money available")

