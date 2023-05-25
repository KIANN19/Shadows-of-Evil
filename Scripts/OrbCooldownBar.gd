extends ProgressBar

func _ready():
	value = 7
	
func Cooldown(time_left) -> void:
	value = time_left


