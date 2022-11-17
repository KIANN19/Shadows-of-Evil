extends Line2D
#
signal laser_deactivated

var laser_active = false

onready var timer = $Energy_timer
onready var raycast =  $RayCast2D

func _ready() -> void:
	visible = false
	raycast.enabled = false
	points[1] = Vector2.ZERO
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Skjut"): 
		if not laser_active:
			pass
			#spela animation appear???, starta energy_timer, laser active = true
			
		raycast.cast_to = points[1]
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var body = raycast.get_collider()
			body.die()
			points[1] = raycast.get_collision_point()
			
		else:
			points[1] = points[1].move_toward(Vector2(600, 0), 5000 * delta)
			
	elif laser_active:
		pass
		#laser ska försvinna
		
func _appear() -> void:
	laser_active = true
	#spela animation:
	if timer.paused:
		timer.paused = false
	else:
		timer.start()
	
	
func _dissapear() -> void:
	laser_active = false
	timer.paused = true
	#spela animation
	
	
	
