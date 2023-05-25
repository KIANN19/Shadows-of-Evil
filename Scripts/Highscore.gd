
extends Control
var k

var highscore = Global.highscore

func _ready():
	$Back.grab_focus()
	$Label.text = "Current highscore: " + str(highscore)
	

func _on_Back_pressed():
	k = SceneTransition.change_scene("res://Scenes/Menu.tscn")

#Sätter highscore till global.highscore, läser från save file.
#Sätter Label-texten till "current highscore" och sedan highscoret som läses från global-scriptet.
