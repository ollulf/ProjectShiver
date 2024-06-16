extends Sprite2D
class_name DonationBowl

var emptyBowl = load("res://assets/Sprites/Manmade/donationBowl-empty.png")
var bowl_full_1 = load("res://assets/Sprites/Manmade/donationBowl-full-1.png")
var bowl_full_2 = load("res://assets/Sprites/Manmade/donationBowl-full-2.png")
var bowl_full_3 = load("res://assets/Sprites/Manmade/donationBowl-full-3.png")
var donationLimit = 30
var currentMoney = 0

static var Bowls = []

@onready var navigation_target = $navigation_target

func _ready():
	add_money(0)
	Bowls.append(self)
	
func add_money(amount):
	currentMoney += amount
	
	if currentMoney > donationLimit:
		currentMoney = donationLimit
		
	if(currentMoney < donationLimit * 0.3 ):
		texture = emptyBowl
	elif (currentMoney < donationLimit * 0.6):
		texture = bowl_full_1
	elif(currentMoney < donationLimit):
		texture = bowl_full_2
	else:
		texture = bowl_full_3
		
func _on_interactable_zone_action_signal():

	if currentMoney > 0:
		MoneyHandler.UpdateMoney(MoneyHandler.currentPlayerMoney + currentMoney)
		add_money(-currentMoney)
		print("retract", currentMoney)
		
	else:
		pass
		#tweenOut = label.create_tween()
		#tweenOut.set_parallel()
		#tweenOut.tween_property(label, "modulate:a", 0, FADE_TIME)
		#tweenOut.tween_property(label, "position", Vector2(labelOriginPosition.x, labelOriginPosition.y), FADE_TIME)

