extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	var enemyscene = load("res://Enemy.tscn")
	
	var screen_size = get_viewport().get_visible_rect().size
	
	for i in range(0,10):
		var enemy = enemyscene.get_instance()
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)
