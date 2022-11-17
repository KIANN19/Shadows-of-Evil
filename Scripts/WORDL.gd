extends Node2D

var enemy_1 = preload("res://Scenes/enemy.tscn")

onready var player = $Player

func _on_Enemy_spawn_timer_timeout():
	var enemy_position = player.global_position + Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	while enemy_position.x < player.global_position.x + 640 and enemy_position.x > -80 or enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
		
	var enemy = enemy_1.instance()
	enemy.global_position = enemy_position
	$Navigation2D/NavigationPolygonInstance.add_child(enemy)
	
	
	
	


