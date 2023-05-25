extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	value = 12
	
func Cooldown(time_left) -> void:
	value = time_left
#cooldown på 12 sekunder, anropas i playerkoden.
