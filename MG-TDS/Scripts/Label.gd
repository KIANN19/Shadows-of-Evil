extends Label

var kills = 0 setget add_kills

func add_kills(v):
	kills += 1
	text = "Kills: "+str(kills)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
