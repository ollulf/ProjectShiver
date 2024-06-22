extends Sprite2D
class_name DonationBowl

var emptyBowl = load("res://assets/Sprites/Manmade/donationBowl-empty.png")
var bowl_full_1 = load("res://assets/Sprites/Manmade/donationBowl-full-1.png")
var bowl_full_2 = load("res://assets/Sprites/Manmade/donationBowl-full-2.png")
var bowl_full_3 = load("res://assets/Sprites/Manmade/donationBowl-full-3.png")
var donationLimit = 30
var currentMoney = 0

static var Bowls = []
const COIN_COLLECT_EFFECT = preload("res://scenes/effects/coin_collect_effect.tscn")

@onready var navigation_target = $navigation_target
@onready var coin_audio = $coinInAudio
@onready var bowl_full_audio = $bowlFullAudio
@onready var bowl_empty_audio = $bowlEmptyAudio
@onready var coin_effect_root = $coinEffectRoot

func _ready():
	#add_money(0)
	Bowls.append(self)
	
func add_money(amounts):
	currentMoney += amounts
	
	coin_audio.play()
	
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
		
func _on_interactable_zone_on_interact():
	if currentMoney > 0:
		bowl_full_audio.play()
		spawn_coins(currentMoney)

		MoneyHandler.UpdateMoney(MoneyHandler.currentPlayerMoney + currentMoney)
		add_money(-currentMoney)
	else:
		bowl_empty_audio.play()

func spawn_coins(amount):
	for i in amount:
		coin_effect_root.add_child(COIN_COLLECT_EFFECT.instantiate())
		await get_tree().create_timer(.1).timeout
