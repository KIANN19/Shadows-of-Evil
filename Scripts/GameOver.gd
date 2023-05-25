extends Control

const SAVE_FILE_PATH = "user://MG-TDS.save"
var kills: int = 0
var highscore: int
var k


func _ready():
	$PlayAgain.grab_focus()
	_on_game_over()
	$TotalKills.text = "Kills: " + str(Global.kills)
	_load_highscore(SAVE_FILE_PATH)
	$TotalTime.text = "Time survived: " + str(Global.time)
	$Highscore.text = "Highscore: " + str(highscore)
	
	#Tangentbortsfocuset hamnar på play again knappen.
	#Sätter olika labels till värderna från global-scriptet, detta för att visa spelarens kills,tid och highscoret.
	
func _on_PlayAgain_pressed():
	k = SceneTransition.change_scene("res://Scenes/World.tscn")
	pass

func _on_Exit_pressed():
	k = SceneTransition.change_scene("res://Scenes/Menu.tscn")
	pass
 
#Spelar en animation från autoload när scenen ändras.

func _load_highscore(FILE_PATH) -> void:
	var save_file = File.new()
	if save_file.file_exists(FILE_PATH):
		save_file.open(FILE_PATH, File.READ)
		highscore = save_file.get_var()
		save_file.close()
	else:
		highscore = 0
		
	#Laddar highscore från save-filen
		
func _save_highscore(FILE_PATH) -> void:
	var save_file = File.new()
	save_file.open(FILE_PATH, File.WRITE)
	save_file.store_var(Global.kills)
	save_file.close()
	#Om ett nytt highscore skulle sättas, tas killsen från det spelet och sätter den mängd kill som det nya highscoret.
	
func _on_game_over() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	Global.new_highscore = false
	if Global.kills > highscore:
		_save_highscore(SAVE_FILE_PATH)
		highscore = Global.kills
		Global.new_highscore = true
		
	Global.highscore = highscore
	

func _on_LineEdit_text_entered(new_text):
	pass # Replace with function body.


func _on_SubmitButton_pressed():
	pass # Replace with function body.
