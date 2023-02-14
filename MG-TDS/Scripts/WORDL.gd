extends Node2D

const WIDTH = 1024
const HEIGHT = 600

var enemy_1 = preload("res://Scenes/enemy.tscn")

onready var player = $Player

func _ready():
	randomize()
	
func _on_Enemy_spawn_timer_timeout():
	var enemy = enemy_1.instance()
	var section = randi() % 4 
	if section == 0:
		enemy.global_position = player.global_position + Vector2(-WIDTH/2 - 20, rand_range(-HEIGHT/2, HEIGHT/2))
	elif section == 1:
		enemy.global_position = player.global_position + Vector2(WIDTH/2 + 20, rand_range(-HEIGHT/2, HEIGHT/2))
	elif section == 2:
		enemy.global_position = player.global_position + Vector2(rand_range(-WIDTH/2, WIDTH/2), -HEIGHT/2 - 20)
	else:
		enemy.global_position = player.global_position + Vector2(rand_range(-WIDTH/2, WIDTH/2), HEIGHT/2 + 20)
	$Navigation2D/NavigationPolygonInstance.add_child(enemy)
	
func _add_point():
	$CanvasLayer/Label.kills += 1
		
