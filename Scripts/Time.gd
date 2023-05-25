extends Label

var time = 0
var timer_on = true

func _process(delta):
	if(timer_on):
		time += delta
		text = var2str(time)
		
	var mils = fmod(time,1) * 1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 60 * 60) /60
	
	var time_passed = "%02d : %02d : %03d" % [mins,secs,mils]
	text = time_passed
	
func _exit_tree():
	Global.time = "%02d : %02d : %03d" % [fmod(time, 60 * 60) /60,fmod(time, 60),fmod(time,1) * 1000]
	
	#skapar en string med variablar som är deinerade till minuter, sekunder och millisekunder,
	#var2str förvandlar värdena och skriver de i text.
	#Startar timer vid 0 och sätter på timern.
	#Extractar tiden vid slut på spel, omvandlar tiden till bättre format.
	
	
