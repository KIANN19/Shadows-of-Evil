extends Control
var k #var k är till för att undvika errorn: change scene returned a value, but this value is never used.

func _ready():
	$VBoxContainer/Easy.grab_focus()
	#Sätter tangentbordfocus på easy-knappen.
	
func _on_Easy_pressed():
	Global.wait_time_enemies = int(2.3)
	k = SceneTransition.change_scene("res://Scenes/World.tscn")

func _on_Medium_pressed():
	Global.wait_time_enemies = int(1.3)

	k = SceneTransition.change_scene("res://Scenes/World.tscn")

func _on_Hard_pressed():
	Global.wait_time_enemies = int(0.4)
	k = SceneTransition.change_scene("res://Scenes/World.tscn")

func _on_Back_pressed():
	k = SceneTransition.change_scene("res://Scenes/Menu.tscn")
	
#Vid knapptryck så laddar man in i spelet. Svårhetsgraden är baserad på Enemy_spawn_timern.
#Värdet är intervallet mellan enemy spawns
