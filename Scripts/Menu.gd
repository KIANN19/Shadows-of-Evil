extends Control
var k

func _ready():
	$VBoxContainer/StartButton.grab_focus()

	#Väljer vart tangentbordsfocuset ska vara, i denna scen är den på startbutton-knappen.

func _on_StartButton_pressed():
	k = SceneTransition.change_scene("res://Scenes/Difficulty.tscn")
	#Spelar en animation och ändrar scen.


func _on_OptionsButton_pressed():
	pass

 
func _on_ExitButton_pressed():
	get_tree().quit()


func _on_ControlsButton_pressed():
	k = SceneTransition.change_scene("res://Scenes/Controls.tscn")
	#Spelar en animation och ändrar scen.


func _on_HighscoreButton_pressed():
	k = SceneTransition.change_scene("res://Scenes/Highscore.tscn")
	#Spelar en animation och ändrar scen.

#Byter scen beroende på knapptryckning
#ScenTransition är en autoload som spelar en animation när man byter scen.
