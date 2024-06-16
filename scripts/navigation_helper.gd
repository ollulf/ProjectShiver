extends Node2D

var map;

var min : Vector2 = Vector2(-1000, -1000)
var max : Vector2= Vector2(1000, 1000)

var inited = false

# Called when the node enters the scene tree for the first time.
func _ready():
	map = get_world_2d(). get_navigation_map()

func get_closest(worldPoint):
	return NavigationServer2D.map_get_closest_point(map, worldPoint)
	
func contains_point(worldPoint):
	return worldPoint.is_equal_approx(get_closest(worldPoint))

func get_random_point():
	var random = get_random_min_max()
	
	while !contains_point(random):
		random = get_random_min_max()
		
	return random
		
func get_random_min_max():
	
	if (!inited):
		min = Vector2(
		get_closest(Vector2(-10000,0)).x,
		get_closest(Vector2(0,-10000)).y
		)
	
		max = Vector2(
		get_closest(Vector2(10000,0)).x,
		get_closest(Vector2(0,10000)).y
		)
		inited = true
	
	return Vector2(randf_range(min.x, max.x), randf_range(min.y, max.y))
