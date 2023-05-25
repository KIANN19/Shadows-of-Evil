extends Control
var k 

func _ready():
	$VideoPlayer/Back.grab_focus()
	#Sätter tangentbordsfocuset på Back-knappen


func _on_Button_pressed():
	k = SceneTransition.change_scene("res://Scenes/Menu.tscn")
#Byter scen till main menu mär knappen trycks.
