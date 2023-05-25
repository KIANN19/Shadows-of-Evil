extends Label

var kills = 0 setget add_kills

func add_kills(_v):
	kills += 1
	text = "Kills: "+str(kills)

func _ready():
	pass

func _exit_tree():
	Global.kills = kills
#Sätter kills till 0 från början och lägger på kills för varje enemy som dödas, detta sker i world-skriptet.
#Extractar killsen vid slut på spel.
