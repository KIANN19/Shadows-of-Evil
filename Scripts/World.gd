extends Node2D

const WIDTH = 1024
const HEIGHT = 600
#Anger spelskärmens storlek

var enemy_1 = preload("res://Scenes/Enemys.tscn")
onready var player = $Player
#anropar enemy och spelaren

func _ready():
	$Enemy_spawn_timer.wait_time = Global.wait_time_enemies
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
	#Börjar med att delar upp spelskärmen i fyra sektioner, baserat på spekskärmens storlek så spawnar enemys utanför skärmen baserat på vart spelaren befinner sig, de fyra sektionerna är till för att slumpmässigt spawna enemys med rand_range. Därmed spawnar jag en enemy med navigation2d anropad som gör så att enemyn följer spelaren.
func _add_point():
	$CanvasLayer/Kills.kills += 1
	#Lägger till en kill i label-scriptet under HUD.
		
