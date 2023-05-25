extends Node

var new_highscore := false
var kills = 0
var time = 0
var highscore = 0
var wait_time_enemies : int


const SAVE_FILE_PATH = "user://MG-TDS.save"
#Väljer save path för highscoret.
#Global värden som går att använda mellan olika scener och scripts. 
func _ready():
	_load_highscore(SAVE_FILE_PATH)
	
func _load_highscore(FILE_PATH) -> void:
	var save_file = File.new()
	if save_file.file_exists(FILE_PATH):
		save_file.open(FILE_PATH, File.READ)
		highscore = save_file.get_var()
		save_file.close()
	else:
		highscore = 0
		
	#Öppnar save_filen och läser innehållet för att visa förra highscoret.


