extends KinematicBody2D

onready var animPlayer = $AnimationPlayer
onready var sprite = $Sprite

var movespeed = 300 
var bullet_speed = 800
var fire_rate = 0.04

var bullet = preload("res://Scenes/BULLET.tscn")
var can_fire = true

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("Skjut") and can_fire: 
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(get_angle_to(get_global_mouse_position())))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	
	if Input.is_action_pressed("Upp"): 
		motion.y -= 1
		animPlayer.play("Walk")
	if Input.is_action_pressed("Ner"): 
		motion.y += 1
		animPlayer.play("Walk")
	if Input.is_action_pressed("Höger"):  
		motion.x += 1
		animPlayer.play("Walk")
	if Input.is_action_pressed("Vänster"): 
		motion.x -= 1
		animPlayer.play("Walk")
		
	if Input.is_action_pressed("Slice"):
		animPlayer.play("Slice")
	
	else: animPlayer.play("Idle")

	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
