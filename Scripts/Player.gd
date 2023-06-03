extends KinematicBody2D

export var BulletBlood = preload("res://Scenes/BulletBlood.tscn")
onready var HUD = get_node("/root/World/CanvasLayer/SliceCooldownBar") 
onready var HUD2 = get_node("/root/World/CanvasLayer/OrbCooldownBar") 
onready var DMG2 = get_node("/root/World/CanvasLayer/DMG2") 
onready var DMG1 = get_node("/root/World/CanvasLayer/DMG1") 
onready var animPlayer = $AnimationPlayer

onready var sprite = $Sprite
onready var healthbar = $TextureProgress
onready var SliceCooldown = $SliceCooldown
onready var OrbCooldown = $OrbCooldown
onready var DamageFX = $DamageFX
#Anropar noder, sätter variabler

const PLAYE = "Player"
var movespeed = 300 
var bullet_speed = 800
var fire_rate = 0.15
var k
#Start-värde på rörelse, firerate och bullet_speed

var hp = 500
var is_dead = false
var is_colliding = false
var Hit = false
#Sätter spelarens liv till 500, säger att spelaren inte tar skada/kolliderar eller är död när spelet börjar.

var Attack = preload("res://Scenes/Enemys.tscn")
var bullet = preload("res://Scenes/Bullets.tscn")
var HealthPickup = preload("res://Scenes/HealthPickup.tscn")
var can_fire = true
#laddar enemy,bullet och extra-liv som man tar upp och sätter namn för variablarna.

func _ready():
	$Sprite/Slice/Shunt.disabled = true
	DamageFX.emitting = false
	DMG2.hide()
	DMG1.hide()
	#fixar bugg där slice animationen spelas så fort man laddar in i spelet.

func _physics_process(_delta):
	if $SliceCooldown.time_left > 0:
		HUD.Cooldown(12-$SliceCooldown.time_left)
		
	if $OrbCooldown.time_left > 0:
		HUD2.Cooldown(7-$OrbCooldown.time_left)
		#sätter hur lång cooldown man vill ha på slice attacken. 12 sec 
	
	if is_colliding:
		hp -= 1
		healthbar.value = hp
		if hp <= 250:
			DMG1.show()
		if hp > 250:
			 DMG1.hide()
		if hp <= 100:
			DMG1.hide()
		if hp <= 100:
			DMG2.show()
		if hp > 100:
			DMG2.hide()
		if hp > 500:
			DMG1.hide()
			DMG2.hide()
		if hp <= 0:
			is_dead = true
			k = get_tree().change_scene("res://Scenes/GameOver.tscn")
		#Om spelaren kolliderar med enemy, tappar man 1hp per hit, startar med 500 liv. om fienden är nära nog så dränks spelarens liv.
		#Om spelarens liv tar slut, byter spelet scen till game over skärmen.
			
	healthbar.hide()
	if hp < 500:
		healthbar.show()
	#om spelaren tar skada visas healthbaren då starthealth är 500, annars syns den inte, för att inte ta upp mycket plats på skärmen.
	#gömmer healthbaren om den är max.
	
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
		# tar bulleten från scen, säger att den ska åt riktningen där min muspekare befinner sig, skjuter med en bullet med impuls mot den riktningen.
		# lägger till en bullet, därmed sätts can_fire = false för att spelaren inte ska konstant skjuta, man skapar en timer/cooldown för hur snabbt man kan avfyra bullets.
	
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
		#sätter rörelse till Vector2() och med imput map väljer knappar för rörelse, om respektive knapp trycks så går spelaren med walk animationen mot den riktningen. +x= höger -y=ner osv.
		
	if Input.is_action_pressed("Slice"):
		if SliceCooldown.is_stopped():
			animPlayer.play("Slice")
			SliceCooldown.start()
			
	if Input.is_action_pressed("BallsofDeath"):
		if OrbCooldown.is_stopped():
			animPlayer.play("BallsOfDeath")
			OrbCooldown.start()
			#Spelar slice animation då knappen trycks, startar cooldwonen då knappen trycks.

	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	#Hastighet

func _on_Slice_body_entered(body):
		if body.is_in_group("Enemy"): 
			var blood = BulletBlood.instance() as Node2D
			blood.position = body.get_global_position()
			get_parent().add_child(blood)
			get_tree().current_scene._add_point()
			body.queue_free()
		if body.is_in_group("Boss"): 
			var blood = BulletBlood.instance() as Node2D
			blood.position = body.get_global_position()
			get_parent().add_child(blood)
			#Om slice träffar enmeyn, spelas bloodeffekten från en annan scen och sätter positionen för blood splatter där enemyn dör, dödar enemyn direkt.
			

func _on_BallsOfDeath_body_entered(body):
		if body.is_in_group("Enemy"): 
			var blood = BulletBlood.instance() as Node2D
			blood.position = body.get_global_position()
			get_parent().add_child(blood)
			get_tree().current_scene._add_point()
			body.queue_free()
		if body.is_in_group("Boss"): 
			var blood = BulletBlood.instance() as Node2D
			blood.position = body.get_global_position()
			get_parent().add_child(blood)
			#Om slice träffar enmeyn, spel
			
			
func _on_Area2D_body_entered(body):
	is_colliding = true
	DamageFX.emitting = true
	if body.is_in_group("BossBullet"): 
		DamageFX.emitting = true
		hp -= 50
		healthbar.value = hp
		

func _on_Area2D_body_exited(_body):
	is_colliding = false
	DamageFX.emitting = false
	#För att veta när playern kolliderar med enemy
	
func pick_up(item_name):
	if item_name == "HealthPickup":
			hp += 500
			if hp > 500:
				hp = 500
				DMG1.hide()
				DMG2.hide()
	elif item_name == "DoubleTap":
		fire_rate = 0.08
	elif item_name == "SpeedCola":
		movespeed = 500
	elif item_name == "WhosWho":
		$Light2D.hide()
		$Light2D2.show()
#Powerups om spelaren kolliderar med en powerup så ändras respektive värde, snabbhet, fire_rate, health.
#Har två light2d noder, ena mindre som är på från start, om man tar powerupen så disablas den light 2dn och en annan sätts på som är större, vilket ger mer vision.

