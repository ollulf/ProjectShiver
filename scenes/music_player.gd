extends Node

var light

@export var day_curve: Curve
@export var night_curve: Curve

@onready var day_music = $DayMusic
@onready var night_music = $NightMusic

func _process(_delta):
	light = DayNightHandler.lightEnergy
	
	day_music.volume_db = linear_to_db(day_curve.sample(light))
	night_music.volume_db = linear_to_db(night_curve.sample(light))
