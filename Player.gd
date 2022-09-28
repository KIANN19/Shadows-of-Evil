extends KinematicBody2D

var movespeed = 300 
var bullet_speed = 3000
var fire_rate = 0.2

var bullet = preload("res://BULLET.tscn")
var can_fire = true

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("Skjut") and can_fire: 
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	
	if Input.is_action_pressed("Upp"): 
		motion.y -= 1
	if Input.is_action_pressed("Ner"): 
		motion.y += 1
	if Input.is_action_pressed("Höger"):  
		motion.x += 1
	if Input.is_action_pressed("Vänster"): 
		motion.x -= 1
		
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	look_at(get_global_mouse_position())
